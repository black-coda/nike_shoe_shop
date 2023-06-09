import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';


class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = ref.watch(authStateNotifierProvider.notifier).state;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/error-404.json"),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              r.maybeMap(
                unauthenticated: (value) {
                  context.go("/");
                },
                authenticated: (value) {
                  context.go('/dashboard');
                },
                orElse: () {},
              );
            },
            child: Text(
              "Go to Homepage",
              style: TextStyle(
                  color: Colors.blue[600], fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
