import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Cart"),
        leading: const LeadReturnBtn(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
