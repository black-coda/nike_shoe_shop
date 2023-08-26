import 'package:cached_network_image/cached_network_image.dart';
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63,
                ),
                itemCount: productNotifier.length,
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
                                    //TODO: To implement favorite feature
                                  },
                                  child: const Icon(
                                    MdiIcons.heartOutline,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              child: CachedNetworkImage(
                                imageUrl: productNotifier[index].productImage ??
                                    "https://hips.hearstapps.com/hmg-prod/images/legacy-fre-image-placeholder-1655513735.png?resize=980:*",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
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
                              onTap: () async {
                                final id = productNotifier[index].id.toString();
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
                                          .retailPriceCents
                                          ?.toPriceFormat()
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
