import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/cart/data/models/cart_item_model.dart';
import 'package:nike_shoe_shop/src/features/cart/ui/controllers/cart_controller.dart';
import 'package:nike_shoe_shop/src/features/core/extension/dollar_extension.dart';
import 'package:nike_shoe_shop/src/features/core/extension/price_formatter_extension.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/image_network_func.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Cart"),
        leading: const LeadReturnBtn(),
        actions: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final cartList = ref.watch(fetchCartProvider);
              if (cartList.hasValue) {
                return Text(cartList.value!.length.toString());
              } else {
                return const Text("0");
              }
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final cartList = ref.watch(fetchCartProvider);

          return cartList.when(
            error: (error, stackTrace) => const Center(
              child: Text("Error While Trying to Load Favorite Products"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0D6EFD),
              ),
            ),
            data: (cartList) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.57,
                  decoration: const BoxDecoration(color: Color(0xffF7F7F9)),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: imageNetwork(cartList, index),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(cartList[index].productName),
                                  Text(
                                    cartList[index]
                                        .price
                                        .toPriceForm()
                                        .toString()
                                        .dollar(),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //* Row which contains the increase and decrease button
                                      Row(
                                        children: [
                                          const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              MdiIcons.minus,
                                              color: Color(0xff0D6EFD),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          //* Number of cart item
                                          Text(
                                            cartList[index]
                                                .productUnit
                                                .toString(),
                                          ),
                                          const SizedBox(width: 10),
                                          const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              MdiIcons.plus,
                                              color: Color(0xff0D6EFD),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //* Remove from cart button
                                      _removeButton(
                                          ref, cartList, index, context)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: cartList.length,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final priceAvailability =
                                ref.watch(getPriceProvider).hasValue;
                            final price = ref
                                .watch(getPriceProvider)
                                .value
                                ?.toPriceForm();
                            return totalPayment(
                              field: "Subtotal",
                              price: priceAvailability
                                  ? price.toString()
                                  : 0.toString(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  IconButton _removeButton(WidgetRef ref, List<CartProduct> cartList, int index,
      BuildContext context) {
    return IconButton(
      onPressed: () async {
        final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
        final productId = cartList[index].id.toString();
        await ref.read(cartStateNotifierProvider.notifier).removeFromCart(
            productId: productId, userId: userId, context: context);
        ref.invalidate(fetchCartProvider);
        ref.invalidate(getPriceProvider);
      },
      icon: const Icon(
        MdiIcons.trashCanOutline,
        color: Color(0xffFF1900),
      ),
    );
  }

  Widget totalPayment({required field, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          field,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff1A2530),
          ),
        ),
        Text(
          price.dollar(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
