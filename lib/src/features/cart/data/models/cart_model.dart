// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

class Cart {
  final UserId userId;
  final List<ProductEntity>? productEntity;
  Cart({
    required this.userId,
    this.productEntity,
  });

  Map<String, dynamic> toFirestore() {
    return {
      if (productEntity != null) "favorite": productEntity as List,
      "user_id": userId,
    };
  }

  factory Cart.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options}) {
    final data = snapshot.data();
    return Cart(
      userId: data?["user_id"],
      productEntity:
          data?["favorite"] is Iterable ? List.from(data?["favorite"]) : null,
    );
  }
}

extension MutableCart on Cart{
  Cart addItem(){
    return Cart(userId: "userId");
  }
}
