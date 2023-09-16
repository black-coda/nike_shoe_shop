import 'package:flutter/foundation.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/data/datasource/base_remote_data_source.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/domain/repositories/remote/product_repository.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteService service;

  ProductRepositoryImpl(this.service);

  @override
  Future<List<ProductEntity>?> getAllProducts() async {
    final result = service.getAllProducts();
    return result;
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final result = service.getProductById(id);
    return result;
  }

  @override
  Future<Set<ProductEntity>?> getFavoriteProducts(UserId userId) async {
    try {
      final result = service.getFavoriteProducts(userId);
      return result;
    } on Exception catch (e) {
      e.log();
    }
    return null;
  }

  @override
  Future<bool> addToFavoriteProduct({
    required String productId,
    required UserId userId,
  }) async {
    try {
      final result = await service.addToFavoriteProduct(
          productId: productId, userId: userId);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
  
  @override
  Future<bool> removeFromFavoriteProduct({required String productId, required UserId userId}) async {
    try {
      final result = await service.removeFromFavoriteProduct(
          productId: productId, userId: userId);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
