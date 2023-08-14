import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>?> getAllProduct();
  Future<ProductEntity?> getProductById(String id);
  // Future<List<ProductEntity>> getFavoriteProducts();
  // Future<void> getFilteredProduct();
}
