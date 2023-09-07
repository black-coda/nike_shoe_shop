import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>?> getAllProducts();
  Future<ProductEntity?> getProductById(String id);
  Future<Set<ProductEntity>?> getFavoriteProducts(UserId userId);
  // Future<void> getFilteredProduct();
}
