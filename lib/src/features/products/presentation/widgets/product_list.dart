import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product/product_grid.dart';

import 'app_bar.dart';
import 'header.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(productStateNotifier.notifier).isLoading;
    // Call getAllProduct() when the widget is initialized
    Future<void> fetchData() async {
      await ref.watch(productStateNotifier.notifier).getAllProduct();
    }

    fetchData();

    final productNotifier = ref.watch(productStateNotifier);

    if (isLoading || productNotifier.isEmpty) {
      return const Scaffold(
        body: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Color(0xff0D6EFD),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          const HeaderWidget(title: "Select Category"),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                          color: index % 2 != 0
                              ? Colors.white
                              : const Color(0xff0D6EFD),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
          ),
          //* Header
          const HeaderWidget(title: "Popular Shoes", isMore: true),
          //* product Card
          ProductGridView(provider: productStateNotifier),
          const HeaderWidget(title: "Popular Shoes", isMore: true),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 90,
            ),
          )
        ],
      ),
    );
  }
}
