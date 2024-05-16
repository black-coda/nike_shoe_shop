import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/Theme/theme_.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(isSignedInProvider).log();

    final routes = ref.watch(goRouterProvider);
    ref.watch(authStateNotifierProvider).maybeMap(
          authenticated: (value) => routes.go("/productList"),
          unauthenticated: (value) => routes.go("/"),
          orElse: () => routes.go("/"),
        );

    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    theme: primaryTheme,
      // home: const OnBoardScreen(),
    );
  }
}
