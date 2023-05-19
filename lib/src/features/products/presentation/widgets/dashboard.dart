import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/provider.dart';

class DashBoardView extends ConsumerWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    ref.read(authStateNotifierProvider.notifier).logoutUser();
                  },
                  child: const Icon(Icons.logout)),
              const Text(
                "Home Dashboard",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
