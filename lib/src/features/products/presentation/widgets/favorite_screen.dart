import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/cart/ui/controllers/cart_controller.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/material_banner.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product/product_card.dart';

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
              ),
            ),
            data: (productList) => Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final userId = ref.watch(firebaseAuthProvider).currentUser?.uid;
                Future<void> removeFromFav(int index) async {
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
                      ..showMaterialBanner(showActionMaterialBanner(
                          context, "Removed from Favorite"));
                  } else {
                    if (!context.mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context)
                      ..hideCurrentMaterialBanner()
                      ..showMaterialBanner(
                          showActionMaterialBanner(context, "Loading..."));
                  }

                  ref.invalidate(getFavoriteFutureProvider);
                }

                Future<void> addToCart(int index) async {
                  await ref.watch(cartStateNotifierProvider.notifier).addToCart(
                      productId: productList![index].id.toString(),
                      userId: userId!,
                      context: context);
                }

                return productList!.isNotEmpty
                    ? CustomScrollView(
                        slivers: <Widget>[
                          ProductCardWidget(
                            productList: productList,
                            modifyFavorite: removeFromFav,
                            addToCart: addToCart,
                            isFavoriteScreen: true,
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
