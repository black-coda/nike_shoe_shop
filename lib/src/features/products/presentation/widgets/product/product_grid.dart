import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/cart/ui/controllers/cart_controller.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/animated_btn.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/image_network_func.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/material_banner.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';

class ProductGridView extends ConsumerWidget {
  const ProductGridView({
    super.key,
    required this.provider,
  });

  final AlwaysAliveProviderBase<Iterable<ProductEntity>>? provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(provider!) as List<ProductEntity>;
    final userId = ref.watch(firebaseAuthProvider).currentUser?.uid;

    Future<void> addToFav(int index) async {
      final isSuccessful = await ref
          .watch(productStateNotifier.notifier)
          .addToFavoriteProduct(
              productId: productList[index].id.toString(), userId: userId!);
      if (isSuccessful) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(successCartBanner);
      } else {
        if (!context.mounted) {
          return;
        }
        debugPrint("😪😪😪😪");
        // ScaffoldMessenger.of(context).showMaterialBanner(removedFromCartBanner);
      }
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
    }

    Future<void> addToCart(int index) async {
      await ref.watch(cartStateNotifierProvider.notifier).addToCart(
          productId: productList[index].id.toString(),
          userId: userId!,
          context: context);
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
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
                          mdiIcons: const Icon(
                            MdiIcons.heartPlus,
                            size: 20.0,
                            color: Color(0xff20daa9),
                          ),
                          onTapped: () async => await addToFav(index),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: imageNetwork(productList, index),
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
                    GestureDetector(
                      onTap: () async {
                        final id = productList[index].id.toString();
                        final product = await ref
                            .read(productStateNotifier.notifier)
                            .getProductById(id);
                        final productID = product.id.toString();
                        // if(!mounted) return;
                        GoRouter.of(context).pushNamed(
                          "productDetail",
                          pathParameters: {
                            "productId": productID,
                          },
                        );
                      },
                      child: Text(
                        productList[index].name ?? '',
                        style: const TextStyle(
                          color: Color(0xff6A6A6A),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        // textAlign: TextAlign.,
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
