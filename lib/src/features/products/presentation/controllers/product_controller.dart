import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/products/application/product_notifier.dart';
import 'package:nike_shoe_shop/src/features/products/data/datasource/base_remote_data_source.dart';
import 'package:nike_shoe_shop/src/features/products/data/repository/product_repository_impl.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/domain/usecases/product_usecases.dart';

final productStateNotifier =
    StateNotifierProvider<ProductStateNotifier, List<ProductEntity>>((ref) {
  final getProductAllUseCase = ref.watch(getAllProductUsecaseProvider);
  final getProductByIdUseCase = ref.watch(getProductByIdUsecaseProvider);
  final getFavoriteUsecase = ref.watch(getFavoriteUsecaseProvider);
  return ProductStateNotifier(
    getProductAllUseCase,
    getProductByIdUseCase,
    getFavoriteUsecase,
  );
});

final getAllProductUsecaseProvider = Provider<GetAllProductUsecases>((ref) {
  final productRepository = ref.watch(productRepositoryImpl);
  return GetAllProductUsecases(productRepository);
});

final getProductByIdUsecaseProvider = Provider<GetProductByIdUseCase>((ref) {
  final productRepository = ref.watch(productRepositoryImpl);
  return GetProductByIdUseCase(productRepository);
});

final getFavoriteUsecaseProvider = Provider<GetFavoriteUsecase>((ref) {
  final productRepository = ref.watch(productRepositoryImpl);
  return GetFavoriteUsecase(productRepository);
});

final productRepositoryImpl = Provider<ProductRepositoryImpl>((ref) {
  final service = ref.watch(serviceProvider);
  return ProductRepositoryImpl(service);
});

final serviceProvider = Provider<ProductRemoteService>((ref) {
  final db = ref.watch(dbProvider);
  return ProductRemoteService(db);
});

//* Favorite
final getFavoriteFutureProvider =
    FutureProvider.autoDispose<List<ProductEntity>?>((ref) async {
  final userId = ref.watch(firebaseAuthProvider).currentUser?.uid;

  final products = await ref
      .watch(productStateNotifier.notifier)
      .getFavoriteProduct(userId!);
  return products?.toList();
});

