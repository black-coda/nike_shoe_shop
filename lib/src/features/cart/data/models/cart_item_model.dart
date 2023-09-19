// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  final String productName;
  final int price;
  final int productUnit;
  final int id;

  CartProduct({
    required this.productName,
    required this.price,
    this.productUnit = 1,
    required this.id,
  });

  CartProduct priceCopyWith({
    int? productUnit,
  }) {
    return CartProduct(
      productName: productName,
      price: price,
      productUnit: productUnit ?? this.productUnit,
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'price': price,
      'productUnit': productUnit,
    };
  }

  factory CartProduct.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options}) {
    final data = snapshot.data();
    return CartProduct(
      productName: data?["name"],
      price: data?["retail"],
      id: data?["id"],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'CartProduct(productName: $productName, price: $price, productUnit: $productUnit)';

  @override
  bool operator ==(covariant CartProduct other) {
    if (identical(this, other)) return true;

    return other.productName == productName && other.price == price;
  }

  @override
  int get hashCode =>
      productName.hashCode ^ price.hashCode ^ productUnit.hashCode;
}
