import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_model.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

abstract class CartBaseRemoteDataSource {
  Future<List<CartProduct>> fetchCart({required UserId userId});

  Future<bool> addToCartProduct(
      {required String productId, required UserId userId});

  Future<bool> removeFromCartProduct(
      {required String productId, required UserId userId});
  Future<int> totalSumOfProducts({required UserId userId});

  Future<void> increaseProductUnit(
      {required String productId, required UserId userId});
  Future<void> decreaseProductUnit(
      {required String productId, required UserId userId});
}

class CartRemoteService extends CartBaseRemoteDataSource {
  final FirebaseFirestore db;

  CartRemoteService({required this.db});

  @override
  Future<bool> addToCartProduct(
      {required String productId, required UserId userId}) async {
    try {
      final cartRef =
          db.collection(FirebaseCollectionName.cart).doc(userId).withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? options) {
          return Cart.fromFirestore(snapshot: snapshot);
        },
        toFirestore: (Cart cart, SetOptions? options) {
          return cart.toFirestore();
        },
      );
      final cartDoc = await cartRef.get();
      if (cartDoc.exists) {
        final Cart? cart = cartDoc.data();
        if (cart != null && cart.cartList!.contains(productId)) {
          return true;
        } else {
          final updateCart = cart!.addItem(productId);
          await cartRef.set(updateCart);
        }
      } else {
        //* If the cart document does not exist, create a new cart instance in Firebase
        final newCart = Cart(cartList: [productId], userId: userId);
        await cartRef.set(newCart);
        return true;
      }

      return true;
    } on Exception catch (e) {
      // Handle any exceptions here
      debugPrint('Error adding to cart: ${e.toString}');
      return false; //* Return false to indicate failure
    }
  }

  @override
  Future<bool> removeFromCartProduct(
      {required String productId, required UserId userId}) async {
    try {
      final cartRef =
          db.collection(FirebaseCollectionName.cart).doc(userId).withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? options) {
          return Cart.fromFirestore(snapshot: snapshot);
        },
        toFirestore: (Cart cart, SetOptions? options) {
          return cart.toFirestore();
        },
      );
      final cartDoc = await cartRef.get();
      if (cartDoc.exists) {
        final Cart? cart = cartDoc.data();
        if (cart != null && cart.cartList!.contains(productId)) {
          final updatedCart = cart.removeItem(productId);
          await cartRef.set(updatedCart);
          return true;
        }
      }

      return false; //* The product was not in the cart
    } on Exception catch (e) {
      //* Handle any exceptions here
      debugPrint('Error removing from cart: ${e.toString()}');
      return false; //* Return false to indicate failure
    }
  }

  @override
  Future<List<CartProduct>> fetchCart({required UserId userId}) async {
    try {
      DocumentReference<Cart> cartRef = await cartFromDB(userId);

      final cartDoc = await cartRef.get();
      final Cart? cart = cartDoc.data();

      if (cart != null) {
        List<CartProduct> cartProduct = await convertToCartProduct(cart);

        return cartProduct;
      } else {
        //* If the cart document does not exist, create a new cart instance in Firebase
        final newCart = Cart(cartList: [], userId: userId);
        await cartRef.set(newCart);
        return <CartProduct>[];
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  //* convert to CartProduct class
  Future<List<CartProduct>> convertToCartProduct(Cart cart) async {
    final productSnapShot = await Future.wait(
      cart.cartList!
          .map(
            (productId) => db
                .collection(FirebaseCollectionName.product)
                .doc(productId)
                .get(),
          )
          .toList(),
    );

    productSnapShot.log();

    final cartProduct = productSnapShot
        .where((product) => product.exists)
        .map((e) => CartProduct.fromFirestore(snapshot: e))
        .toList();

    return cartProduct;
  }

//* create DocumentReference from db
  Future<DocumentReference<Cart>> cartFromDB(UserId userId) async {
    final cartRef = db
        .collection(FirebaseCollectionName.cart)
        .doc(userId)
        .withConverter<Cart>(
      fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot,
          SnapshotOptions? options) {
        return Cart.fromFirestore(snapshot: snapshot);
      },
      toFirestore: (Cart cart, _) {
        return cart.toFirestore();
      },
    );
    // Check if the document exists
    final cartDoc = await cartRef.get();
    if (!cartDoc.exists) {
      // If it doesn't exist, create a new cart instance in Firebase
      final newCart = Cart(cartList: [], userId: userId);
      await cartRef.set(newCart);
    }

    return cartRef;
  }

  //* Calculate total
  @override
  Future<int> totalSumOfProducts({required UserId userId}) async {
    final cartRef = await cartFromDB(userId);
    final cartDoc = await cartRef.get();
    final Cart? cart = cartDoc.data();
    var totalSum = 0;
    if (cart != null) {
      if (cart.cartList != null) {
        final products = await convertToCartProduct(cart);
        return products.fold<int>(
            0, (sum, product) => sum + (product.price * product.productUnit));
      }
    }
    return totalSum;
  }

  @override
  Future<void> increaseProductUnit({
    required String productId,
    required UserId userId,
  }) async {
    final cartRef = await cartFromDB(userId);
    final cartDoc = await cartRef.get();
    final Cart? cart = cartDoc.data();
    if (cart!.cartList!.isNotEmpty) {
      final products = await convertToCartProduct(cart);
      for (var cartProduct in products) {
        if (cartProduct.id.toString() == productId) {
          final initialUnit = cartProduct.productUnit;
          final increase = initialUnit + 1;
          cartProduct.priceCopyWith(productUnit: increase);
        }
      }
    }
  }

  @override
  Future<void> decreaseProductUnit(
      {required String productId, required UserId userId}) async {
    final cartRef = await cartFromDB(userId);
    final cartDoc = await cartRef.get();
    final Cart? cart = cartDoc.data();
    if (cart!.cartList!.isNotEmpty) {
      final products = await convertToCartProduct(cart);
      for (var cartProduct in products) {
        if (cartProduct.id.toString() == productId) {
          final initialUnit = cartProduct.productUnit;
          if (initialUnit != 0) {
            final decrease = initialUnit - 1;
            cartProduct.priceCopyWith(productUnit: decrease);
          } else {
            cartProduct.priceCopyWith(productUnit: initialUnit);
          }
        }
      }
    }
  }
}
