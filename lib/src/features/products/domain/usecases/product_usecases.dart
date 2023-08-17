import 'package:nike_shoe_shop/src/features/products/data/repository/product_repository_impl.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/core/usecases/usecases.dart';

class GetAllProductUsecases extends UseCase<List<ProductEntity?>, void> {
  final ProductRepositoryImpl _productRepository;

  GetAllProductUsecases(this._productRepository);

  @override
  Future<List<ProductEntity>?> call({void params}) async {
    final data = _productRepository.getAllProduct();
    return data;
  }
}

class GetProductByIdUseCase extends UseCase<ProductEntity?, String> {
  final ProductRepositoryImpl _productRepository;

  GetProductByIdUseCase(this._productRepository);

  @override
  Future<ProductEntity?> call({required String params}) {
    final data = _productRepository.getProductById(params);
    return data;
  }
}
