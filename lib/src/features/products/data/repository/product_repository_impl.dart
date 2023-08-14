import 'package:nike_shoe_shop/src/features/products/data/datasource/base_remote_data_source.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/domain/repositories/remote/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteService service;

  ProductRepositoryImpl(this.service);

  @override
  Future<List<ProductEntity>?> getAllProduct() async {
    final result = service.getAllProduct();

    return result;
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final result = service.getProductById(id);
    return result;
  }
}
