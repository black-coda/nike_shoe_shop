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
  Future<bool> addToFavoriteProduct(
      {required String productId, required UserId userId});
  Future<bool> removeFromFavoriteProduct(
      {required String productId, required UserId userId});
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

  @override
  Future<bool> addToFavoriteProduct(
      {required String productId, required UserId userId}) async {
    try {
      final favoriteProductRef =
          db.collection(FirebaseCollectionName.favorite).doc(userId);

      final favoriteProductSnapshot = await favoriteProductRef.get();
      final favoriteProductData = favoriteProductSnapshot.data();

      // Check if the favorite field exists in the document data
      if (favoriteProductData != null &&
          favoriteProductData.containsKey('favorite')) {
        final favoriteProductIdList =
            List<String>.from(favoriteProductData['favorite']);

        // Check if productId is already in the favorite list
        if (favoriteProductIdList.contains(productId)) {
          return true;
          // Product is already in favorites
        } else {
          favoriteProductIdList.add(productId);
          await favoriteProductRef.update({'favorite': favoriteProductIdList});
          debugPrint("Favorite List Successfully Updated");
          return true; // Product added to favorites
        }
      } else {
        // If 'favorite' field doesn't exist, create a new one
        await favoriteProductRef.set({
          'favorite': [productId],
          "user_id": userId,
        });
        debugPrint("Favorite List Successfully Created");
        return true; // Product added to favorites
      }
    } catch (e) {
      debugPrint("Error adding to favorites: $e");
      return false; // An error occurred while adding to favorites
    }
  }

  @override
  Future<bool> removeFromFavoriteProduct(
      {required String productId, required UserId userId}) async {
    try {
      final favoriteProductRef =
          db.collection(FirebaseCollectionName.favorite).doc(userId);

      final favoriteProductSnapshot = await favoriteProductRef.get();
      final favoriteProductData = favoriteProductSnapshot.data();

      // Check if the favorite field exists in the document data
      if (favoriteProductData != null &&
          favoriteProductData.containsKey('favorite')) {
        final favoriteProductIdList =
            List<String>.from(favoriteProductData['favorite']);

        // Check if productId is in the favorite list
        if (favoriteProductIdList.contains(productId)) {
          // Remove productId from the list
          favoriteProductIdList.remove(productId);

          // Update the 'favorite' field with the modified list
          await favoriteProductRef.update({'favorite': favoriteProductIdList});

          debugPrint("Product Removed from Favorites");
          return true; // Product removed from favorites
        } else {
          return true; // Product was not in favorites, so nothing to remove
        }
      } else {
        // If 'favorite' field doesn't exist, there's nothing to remove
        return true; // Product was not in favorites, so nothing to remove
      }
    } catch (e) {
      debugPrint("Error removing from favorites: $e");
      return false; // An error occurred while removing from favorites
    }
  }
}
