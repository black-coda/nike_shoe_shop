import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/cart/application/cart_notifier.dart';
import 'package:nike_shoe_shop/src/features/cart/data/datasource/base_remote_source.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/data/repository/cart_repository_impl.dart';
import 'package:nike_shoe_shop/src/features/cart/domain/usecases/cart_usecase.dart';

//* cart service provider
final carServiceProvider = Provider<CartRemoteService>(
  (ref) {
    final db = ref.watch(dbProvider);
    return CartRemoteService(db: db);
  },
);

//* cart repo implementation provider
final cartRepoProvider = Provider<CartRepositoryImpl>(
  (ref) {
    final cartService = ref.watch(carServiceProvider);
    return CartRepositoryImpl(cartService: cartService);
  },
);

//* cart use case provider
final cartUsecaseProvider = Provider<CartUsecase>(
  (ref) {
    final cartRepositoryImpl = ref.watch(cartRepoProvider);
    return CartUsecase(cartRepositoryImpl);
  },
);

//* cart state notifier provider
final cartStateNotifierProvider =
    StateNotifierProvider<CartStateNotifier, List<CartProduct>>(
  (ref) {
    final cartUsecase = ref.watch(cartUsecaseProvider);
    return CartStateNotifier(cartUsecase: cartUsecase);
  },
);
