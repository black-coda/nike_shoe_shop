import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

abstract class CartBaseRemoteDataSource {
  Future<Map<String, dynamic>?> getCartProducts({required UserId userId});
  Future<bool> addToCartProduct(
      {required String productId, required UserId userId});
  Future<bool> removeFromCartroduct(
      {required String productId, required UserId userId});
}

class CartRemoteService extends CartBaseRemoteDataSource {
  final FirebaseFirestore db;

  CartRemoteService({required this.db});

  @override
  Future<Map<String, dynamic>?> getCartProducts({
    required UserId userId,
  }) async {
    try {
      final cartRef =
          await db.collection(FirebaseCollectionName.cart).doc(userId).get();
      if (cartRef.exists) {
        final cartData = cartRef.data();
        if (cartData!["userId"] == userId) {
          return cartData;
        }
      } else {
        return <String, dynamic>{};
      }
    } on Exception catch (e) {
      debugPrint(
        e.toString(),
      );
    }
    return null;
  }
  
  @override
  Future<bool> addToCartProduct({required String productId, required UserId userId}) {
    // TODO: implement addToCartProduct
    throw UnimplementedError();
  }
  
  @override
  Future<bool> removeFromCartroduct({required String productId, required UserId userId}) {
    // TODO: implement removeFromCartroduct
    throw UnimplementedError();
  }

  
}
