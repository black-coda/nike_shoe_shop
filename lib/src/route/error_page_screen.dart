import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* Check if user is authenticated, if authenticated: Redirects back to the productList
    //* else redirects user to splash page

    void checkStatus(context) async {
      final isSignedIn =
          ref.watch(authStateNotifierProvider.notifier).checkSignedIn();
      final checkAuth = await isSignedIn;

      switch (checkAuth) {
        case true:
          context.go("/productList");

        case false:
          context.go("/");

          break;
        default:
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/error-404.json"),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              checkStatus(context);
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
