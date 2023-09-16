import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/data/models/product_model.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/domain/usecases/product_usecases.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class ProductStateNotifier extends StateNotifier<List<ProductEntity>> {
  ProductStateNotifier(this._getPAllProductUsecases,
      this._getProductByIdUseCase, this._getFavoriteProductUsecase)
      : super([]);

  final GetAllProductUsecases _getPAllProductUsecases;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final GetFavoriteUsecase _getFavoriteProductUsecase;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateFavorite(
      {required ProductModel product, required bool isFavorite}) {}

  Future<void> getAllProduct() async {
    _isLoading = true;
    try {
      final productCall = await _getPAllProductUsecases.call();

      if (productCall != null) {
        state = productCall;
      }
    } on Exception catch (e) {
      e.log();
    } finally {
      _isLoading = false;
    }
  }

 
  Future<Set<ProductEntity>?> getFavoriteProduct(UserId userId) async {
    _isLoading = true;
    try {
      final productCall = await _getFavoriteProductUsecase.call(params: userId);
      _isLoading = false;
      if (productCall != null) {
        final favoriteList = productCall.toList();
        state = favoriteList;
        return productCall;
      }
    } on Exception catch (e) {
      e.log();
    } finally {
      _isLoading = false;
    }
    return <ProductEntity>{};
  }

  Future<ProductEntity> getProductById(String id) async {
    try {
      final product = await _getProductByIdUseCase.call(params: id);
      if (product != null) {
        return product;
      }
      throw Exception("Product not found");
    } catch (e) {
      e.log();
      debugPrint('Error fetching product by ID: $e');
      rethrow; // Rethrow the exception for upper layers to handle
    }
  }

  Future<bool> addToFavoriteProduct({
    required String productId,
    required UserId userId,
  }) async {
    try {
      final isFavorite = await _getFavoriteProductUsecase.addToFavoriteProduct(productId: productId, userId: userId);
      return isFavorite;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> removeFromFavoriteProduct({
    required String productId,
    required UserId userId,
  }) async {
    try {
      final isFavorite = await _getFavoriteProductUsecase.removeFromFavoriteProduct(
          productId: productId, userId: userId);
      return isFavorite;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
