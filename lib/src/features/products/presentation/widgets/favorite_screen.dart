import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/animated_btn.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/image_network_func.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/material_banner.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite screen"),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final favoriteProductsList = ref.watch(getFavoriteFutureProvider);

          return favoriteProductsList.when(
            error: (error, stackTrace) => const Center(
              child: Text("Error While Trying to Load Favorite Products"),
            ),
            loading: () => const Center(
                child: CircularProgressIndicator(
              color: Color(0xff0D6EFD),
            )),
            data: (productList) => Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final userId = ref.watch(firebaseAuthProvider).currentUser?.uid;
                Future<void> onTap(int index) async {
                  final isSuccessful = await ref
                      .watch(productStateNotifier.notifier)
                      .removeFromFavoriteProduct(
                          productId: productList![index].id.toString(),
                          userId: userId!);
                  if (isSuccessful) {
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showMaterialBanner(removedFromCartBanner);
                  } else {
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showMaterialBanner(removedFromCartBanner);
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  });

                  ref.invalidate(getFavoriteFutureProvider);
                }

                return productList!.isNotEmpty
                    ? CustomScrollView(
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            sliver: SliverGrid.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      color: Color(0xffFFFFFF),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 12, right: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //* Favorite Icon Button
                                          Row(
                                            children: [
                                              AnimatedIconButton(
                                                mdiIcons: Icon(
                                                  MdiIcons.heartMinus,
                                                  size: 20.0,
                                                  color: Colors.red,
                                                ),
                                                onTapped: () async =>
                                                    await onTap(index),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            child: imageNetwork(
                                                productList, index),
                                          ),
                                          Text(
                                            productList[index].brandName ?? "",
                                            style: const TextStyle(
                                              color: Color(0xff0D6EFD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          GestureDetector(
                                            onTap: () async {
                                              final id = productList[index]
                                                  .id
                                                  .toString();
                                              final product = await ref
                                                  .read(productStateNotifier
                                                      .notifier)
                                                  .getProductById(id);
                                              final productID =
                                                  product.id.toString();
                                              if (!context.mounted) {
                                                return;
                                              }
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                onPressed: () {
                                                  // TODO; Implement add to cart functionality
                                                },
                                                icon: Icon(
                                                  MdiIcons.cartPlus,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(child: Text("No Favorite Product")),
                          const SizedBox(height: 8),
                          TextButton(
                            child: const Text("Go to Home"),
                            onPressed: () => context.go("/productList"),
                          )
                        ],
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
