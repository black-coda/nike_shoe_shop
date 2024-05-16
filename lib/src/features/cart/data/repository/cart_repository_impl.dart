import 'package:flutter/foundation.dart';
import 'package:nike_shoe_shop/src/features/cart/data/datasource/base_remote_source.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/domain/infra/remote/cart_repository.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteService cartService;

  CartRepositoryImpl({required this.cartService});

  @override
  Future<bool> addToCartProduct(
      {required String productId, required UserId userId}) async {
    try {
      final result = await cartService.addToCartProduct(
          productId: productId, userId: userId);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<List<CartProduct>> fetchCart({required UserId userId}) async {
    try {
      final result = await cartService.fetchCart(userId: userId);
      return result;
    } catch (e) {
      e.log();
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<bool> removeFromCartProduct(
      {required String productId, required UserId userId}) async {
    try {
      final result = await cartService.removeFromCartProduct(
          productId: productId, userId: userId);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future<int> totalSumOfProducts({required UserId userId}) async {
    try {
      final r = await cartService.totalSumOfProducts(userId: userId);
      return r;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}
