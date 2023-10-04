// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';


class Cart {
  final UserId userId;
  final List<String>? cartList;

  Cart({
    required this.userId,
    this.cartList,
  });

  Map<String, dynamic> toFirestore() {
    return {
      if (cartList != null) "cartList": cartList as List,
      "userId": userId,
    };
  }

  factory Cart.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options}) {
    final data = snapshot.data();
    return Cart(
      userId: data?["userId"],
      cartList:
          data?["cartList"] is Iterable ? List.from(data?["cartList"]) : null,
    );
  }

 
}

extension MutableCart on Cart {
  Cart addItem(String product) {
    final updatedCartList = List<String>.from(cartList as Iterable)
      ..add(product); // Create a new list with the added product
    return Cart(userId: userId, cartList: updatedCartList);
  }

  Cart removeItem(String product) {
    final updatedCartList = List<String>.from(cartList as Iterable)
      ..remove(product);
    return Cart(userId: userId, cartList: updatedCartList);
  }



 
}
