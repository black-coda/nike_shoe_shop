// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  final String productName;
  final String productImage;
  final int price;
  final int productUnit;
  final int id;

  CartProduct({
    required this.productName,
    required this.productImage,
    required this.price,
    this.productUnit = 1,
    required this.id,
  });

  CartProduct priceCopyWith({
    int? productUnit,
  }) {
    return CartProduct(
      productName: productName,
      productImage: productImage,
      price: price,
      productUnit: productUnit ?? this.productUnit,
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'photoUrl': productImage,
      'price': price,
      'productUnit': productUnit,
      'id': id,
    };
  }

  factory CartProduct.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options}) {
    final data = snapshot.data();
    
    

    return CartProduct(
      productName: data?["name"],
      productImage: data?["original_picture_url"],
      price: data?["retail_price_cents"],
      id: data?["id"],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CartProduct(productName: $productName, photoUrl: $productImage, price: $price, productUnit: $productUnit, id: $id)';
  }

  @override
  bool operator ==(covariant CartProduct other) {
    if (identical(this, other)) return true;
  
    return 
      other.productName == productName &&
      other.productImage == productImage &&
      other.price == price &&
      other.productUnit == productUnit &&
      other.id == id;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
      productImage.hashCode ^
      price.hashCode ^
      productUnit.hashCode ^
      id.hashCode;
  }
}
