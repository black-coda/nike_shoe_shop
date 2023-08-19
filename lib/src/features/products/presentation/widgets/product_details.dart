import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.productID, super.key});

  final String productID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productFuture =
        ref.watch(productStateNotifier.notifier).getProductById(productID);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(MdiIcons.cartOutline),
          ),
        ],
        title: const Text(
          "Sneaker Shop",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const LeadReturnBtn(),
      ),
      body: FutureBuilder(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error} 😪");
          } else if (snapshot.hasData) {
            final product = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    product?.name ?? "",
                    style: const TextStyle(
                      color: Color(0xFF2B2B2B),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product?.brandName ?? "".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff707B81),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product?.retailPriceCents
                            ?.toPriceFormat()
                            .toString()
                            .dollar() ??
                        "",
                    style: const TextStyle(
                      color: Color(0xff2B2B2B),
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Image.network(product?.productImage ?? ""),
                  Image.asset("assets/images/others/shadow.png"),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Product Not Found",
                style: TextStyle(
                  color: Color(0xffFf4c24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
