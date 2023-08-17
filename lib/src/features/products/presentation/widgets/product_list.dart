import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';

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
      return const Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
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
                        color: index % 2 != 0 ? Colors.amber : Colors.pink,
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
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.69,
            ),
            itemCount: productNotifier.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 53.5,
                  width: 34,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: index % 2 != 0 ? Colors.yellow : Colors.red,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Favorite Icon Button
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //TODO: To implement live feature
                              },
                              child: const Icon(
                                MdiIcons.heartOutline,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          child: Image.network(
                            productNotifier[index].productImage!,
                            fit: BoxFit.contain,
                            height: 120,
                            width: 150,
                          ),
                        ),
                        Text(
                          productNotifier[index].brandName!,
                          style: const TextStyle(
                            color: Color(0xff0D6EFD),
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        GestureDetector(
                          onTap: () async{
                            final id = productNotifier[index].id.toString();
                            final product = await ref.read(productStateNotifier.notifier).getProductById(id);
                            GoRouter.of(context).push("location");
                            
                          },
                          child: Text(
                            productNotifier[index].name ?? '',
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
                              productNotifier[index]
                                  .retailPriceCents!
                                  .toPriceFormat()
                                  .toString()
                                  .dollar(),
                              style: const TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // TODO; Implemt add to cart functionality
                              },
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
        ),
        const HeaderWidget(title: "Popular Shoes", isMore: true),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 90,
          ),
        )
      ],
    ));
  }
}
