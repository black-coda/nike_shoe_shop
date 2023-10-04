import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/data/repository/cart_repository_impl.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/features/core/usecases/usecases.dart';

class CartUsecase extends UseCase<List<CartProduct>, UserId> {
  final CartRepositoryImpl _cartRepositoryImpl;

  CartUsecase(this._cartRepositoryImpl);
  @override
  Future<List<CartProduct>?> call({required UserId params}) {
    final data = _cartRepositoryImpl.fetchCart(userId: params);
    return data;
  }

  Future<bool> addToCartProduct(
      {required String productId, required UserId userId}) async {
    final data = _cartRepositoryImpl.addToCartProduct(
        productId: productId, userId: userId);
    return data;
  }

  Future<bool> removeFromCartProduct(
      {required String productId, required UserId userId}) async {
    final data = _cartRepositoryImpl.removeFromCartProduct(
        productId: productId, userId: userId);
    return data;
  }

  Future<int> totalSumOfProducts({required UserId userId}) async{
    final data =  await _cartRepositoryImpl.totalSumOfProducts(userId: userId);
    return data;
  }
}
