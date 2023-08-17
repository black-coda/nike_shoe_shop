import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

import '../models/product_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<ProductEntity>?> getAllProduct();
  Future<ProductEntity?> getProductById(String id);
  Future<void> favoriteProduct();
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
  Future<List<ProductEntity>?> getAllProduct() async {
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
  
  @override
  Future<void> favoriteProduct() {
    // TODO: implement favoriteProduct
    throw UnimplementedError();
  }
}
