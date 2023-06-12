import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/utils/custom_curved_nav_bar.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // bottomNavigationBar: const CustomCurvedNavigationBar(),
      appBar: AppBar(
        title: const Text("Product's Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                ref.watch(authStateNotifierProvider.notifier).logoutUser();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/test2'),
              child: const Text(
                "My Text",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      bottomNavigationBar: const CustomCurvedNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "I am Monday",
                style: TextStyle(),
              ),
              TextField(),
              Text(
                "I am Monday",
                style: TextStyle(),
              ),
              TextField(),
              Text(
                "I am Monday",
                style: TextStyle(),
              ),
              TextField(),
              Text(
                "I am Monday",
                style: TextStyle(),
              ),
              TextField(),
            ]),
      ),
    );
  }
}
