import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({required this.productID, super.key});

  final String productID;

  @override
  Widget build(BuildContext context) {
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
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final productFuture = ref
              .watch(productStateNotifier.notifier)
              .getProductById(productID);
          return FutureBuilder(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff0D6EFD),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error} 😪");
              } else if (snapshot.hasData) {
                final product = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 14),
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
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: product?.productImage ??
                              "https://hips.hearstapps.com/hmg-prod/images/legacy-fre-image-placeholder-1655513735.png?resize=980:*",
                          height: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.scaleDown,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      // TODO: Check out this
                      // Image.asset(
                      //   "assets/images/others/shadow.png",
                      //   height: MediaQuery.of(context).size.height * 0.2,
                      // ),

                      Text(
                        product?.storyHtml
                                ?.replaceAll("<p>", "")
                                .replaceAll("&#", " & ")
                                .replaceAll("</p>", "") ??
                            "Discover a versatile and stylish choice with these shoes. Designed for comfort and crafted with care, they are the perfect addition to your wardrobe. Whether you're strolling through the city or relaxing with friends, these shoes will keep you looking great and feeling comfortable.",
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff707B81),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              // TODO: Add to Favorite 
                            },
                            child: const Icon(
                              MdiIcons.heartOutline,
                              size: 30,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                                backgroundColor: const Color(0xff0D6EFD),
                                foregroundColor: const Color(0xffffffff)),
                            onPressed: () {
                              // TODO: Implement Add to Cart functionality
                            },
                            icon: const Icon(MdiIcons.cartPlus),
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      )
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
          );
        },
      ),
    );
  }
}
