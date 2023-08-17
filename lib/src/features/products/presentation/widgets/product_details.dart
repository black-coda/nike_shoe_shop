import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({this.product, super.key});

  final ProductEntity? product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [Icon(MdiIcons.cartOutline)],
        title: const Text(
          "Sneaker Shop",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const LeadReturnBtn(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            product?.name ?? "",
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product?.brandName ?? "",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff707B81),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product?.retailPriceCents?.toPriceFormat().toString().dollar() ??
                "",
            style: const TextStyle(
              color: Color(0xff2B2B2B),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
