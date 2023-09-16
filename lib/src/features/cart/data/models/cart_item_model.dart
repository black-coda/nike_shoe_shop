// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartProduct {
  final String productName;
  final String price;
  final int productUnit;

  CartProduct({
    required this.productName,
    required this.price,
    this.productUnit = 1,
  });

  CartProduct priceCopyWith({
    int? productUnit,
  }) {
    return CartProduct(
      productName: productName,
      price: price,
      productUnit: productUnit ?? this.productUnit,
    );
  }
}
