import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/animated_btn.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/image_network_func.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';

import '../../controllers/product_controller.dart';

class ProductCardWidget extends ConsumerWidget {
  const ProductCardWidget({
    super.key,
    required this.productList,
    required this.modifyFavorite,
    required this.addToCart,
    this.isFavoriteScreen = false,
  });
  final List<ProductEntity> productList;
  final Function(int) modifyFavorite;
  final Function(int) addToCart;
  final bool isFavoriteScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.orientationOf(context);
    
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          childAspectRatio: 0.63,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 53.5,
              width: 34,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color(0xffFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Favorite Icon Button
                    Row(
                      children: [
                        AnimatedIconButton(
                          mdiIcons: Icon(
                            MdiIcons.heartPlus,
                            size: 20.0,
                            color: !isFavoriteScreen
                                ? const Color(0xff20daa9)
                                : const Color(0xFFF70000),
                          ),
                          onTapped: () async => await modifyFavorite(index),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        final router = GoRouter.of(context);
                        final id = productList[index].id.toString();
                        final product = await ref
                            .read(productStateNotifier.notifier)
                            .getProductById(id);
                        final productID = product.id.toString();

                        router.pushNamed(
                          "productDetail",
                          pathParameters: {
                            "productId": productID,
                          },
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Hero(
                                tag: "product-hero-${productList[index].id}",
                                child: imageNetwork(productList, index)),
                          ),
                          Text(
                            productList[index].brandName!,
                            style: const TextStyle(
                              color: Color(0xff0D6EFD),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            productList[index].name ?? '',
                            style: const TextStyle(
                              color: Color(0xff6A6A6A),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            // textAlign: TextAlign.,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productList[index]
                                  .retailPriceCents
                                  ?.toPriceForm()
                                  .toString()
                                  .dollar() ??
                              "",
                          style: const TextStyle(
                            color: Color(0xff2B2B2B),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () async => await addToCart(index),
                          icon: const Icon(
                            MdiIcons.cartPlus,
                            size: 24,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
