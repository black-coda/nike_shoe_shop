import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/cart/ui/controllers/cart_controller.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/material_banner.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';

import 'product_card.dart';

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
          ..showMaterialBanner(
              showActionMaterialBanner(context, "Added to Favorite"));
      } else {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(showActionMaterialBanner(context, "Loading..."));
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

    return ProductCardWidget(
      productList: productList,
      addToCart: addToCart,
      modifyFavorite: addToFav,
    );
  }
}
