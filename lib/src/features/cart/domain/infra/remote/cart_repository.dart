import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';

abstract class CartRepository{
  Future<List<CartProduct>> fetchCart({required UserId userId});

  Future<bool> addToCartProduct(
      {required String productId, required UserId userId});

  Future<bool> removeFromCartProduct(
      {required String productId, required UserId userId});
}