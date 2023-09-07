import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/products/data/repository/product_repository_impl.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/core/usecases/usecases.dart';

class GetAllProductUsecases extends UseCase<List<ProductEntity?>, void> {
  final ProductRepositoryImpl _productRepository;

  GetAllProductUsecases(this._productRepository);

  @override
  Future<List<ProductEntity>?> call({void params}) async {
    final data = _productRepository.getAllProducts();
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

class GetFavoriteUsecase extends UseCase<Set<ProductEntity>?, UserId> {
  final ProductRepositoryImpl _productRepository;

  GetFavoriteUsecase(this._productRepository);

  @override
  Future<Set<ProductEntity>?> call({required UserId params}) {
    final data = _productRepository.getFavoriteProducts(params);
    return data;
  }
}
