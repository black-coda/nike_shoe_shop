import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_field_name.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';

import '../models/product_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<ProductEntity>?> getAllProducts();
  Future<ProductEntity?> getProductById(String id);
  Future<Set<ProductEntity>?> getFavoriteProducts(UserId userId);
}

class ProductRemoteService extends BaseRemoteDataSource {
  final FirebaseFirestore db;

  ProductRemoteService(this.db);

  @override
  Future<ProductEntity?> getProductById(String id) async {
    try {
      final productRef = await db
          .collection(FirebaseCollectionName.product)
          .doc(id)
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, _) =>
                ProductModel.fromFirestore(snapshot: snapshot),
            toFirestore: (ProductModel productModel, _) =>
                productModel.toFirestore(),
          )
          .get();
      final ProductModel? data = productRef.data();
      if (productRef.data() != null) {
        return data?.toEntity();
      }
      return null;
    } catch (e) {
      e.log();
    }

    throw UnimplementedError();
  }

  //* Get all product

  @override
  Future<List<ProductEntity>?> getAllProducts() async {
    try {
      final productsRef = db
          .collection(FirebaseCollectionName.product)
          .withConverter<ProductModel>(
            fromFirestore: (snapShot, _) =>
                ProductModel.fromFirestore(snapshot: snapShot),
            toFirestore: (ProductModel productModel, _) =>
                productModel.toFirestore(),
          );

      final querySnapShot = await productsRef.get();
      final d = querySnapShot.docs.map((e) => e.data().toEntity()).toList();
      return d;
    } on Exception catch (e) {
      e.log();
    }

    return null;
  }

// * Get Favorite products
  @override
  Future<Set<ProductEntity>?> getFavoriteProducts(UserId userId) async {
    try {
      final favoriteProductDocRef = await db
          .collection(FirebaseCollectionName.favorite)
          .doc(userId)
          .get();
          debugPrint(favoriteProductDocRef.data().toString());
      if (favoriteProductDocRef.exists) {
        final favoriteData = favoriteProductDocRef.data();
        //* returns a string of id which are in the favorite collection
        final favoriteProductsId =
            List<String>.from(favoriteData?[FirebaseFieldName.favorite]);
        
        debugPrint(favoriteData.toString());

        //* Get product from db through their ID
        final productsSnapShots = await Future.wait(
          favoriteProductsId.map(
            (productId) => db
                .collection(FirebaseCollectionName.product)
                .doc(productId)
                .get(),
          ),
        );

        final favoriteProducts = productsSnapShots
            .where((product) => product.exists)
            .map((existedProductSnapshot) =>
                ProductModel.fromFirestore(snapshot: existedProductSnapshot)
                    .toEntity())
            .toSet();

        return favoriteProducts;
      } else {
        return <ProductEntity>{};
      }
    } on Exception catch (e) {
      e.log();
    }
    return null;
  }
}
