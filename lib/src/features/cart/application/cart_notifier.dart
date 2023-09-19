import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/domain/usecases/cart_usecase.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/material_banner.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class CartStateNotifier extends StateNotifier<List<CartProduct>> {
  CartStateNotifier({required this.cartUsecase}) : super([]);

  final CartUsecase cartUsecase;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<void> fetchCart(UserId userId) async {
    _isLoading = true;
    try {
      final fetchCartCall = await cartUsecase.call(params: userId);
      if (fetchCartCall != null) {
        state = fetchCartCall;
      }
    } catch (e) {
      e.log();
    } finally {
      _isLoading = false;
    }
  }

  Future<void> addToCart(
      {required String productId,
      required UserId userId,
      required context}) async {
    _isLoading = true;
    try {
      final isAddedToCart = await cartUsecase.addToCartProduct(
          productId: productId, userId: userId);
      if (isAddedToCart) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showMaterialBanner(successCartBanner);
      }
    } catch (e) {
      e.log();
    }
  }

  Future<void> removeFromCart(
      {required String productId,
      required UserId userId,
      required context}) async {
    _isLoading = true;
    try {
      final isRemovedFromCart = await cartUsecase.removeFromCartProduct(
          productId: productId, userId: userId);
      if (isRemovedFromCart) {
        scaffoldMessenger(context);
      } else {
        scaffoldMessenger(context);
      }
    } catch (e) {
      e.log();
    } finally {
      _isLoading = false;
    }
  }
}
