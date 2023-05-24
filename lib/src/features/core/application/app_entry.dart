import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/Theme/theme_.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/provider.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(isSignedInProvider).log();
    // ref.listen(isSignedInProvider, (previous, next) {});
    final routes = ref.watch(goRouterProvider);
    ref.watch(authStateNotifierProvider).maybeMap(
          authenticated: (value) => routes.go("/dashboard"),
          unauthenticated: (value) => routes.go("/"),
          isLoading: (value) {
            
          },
          orElse: () {},
        );
        // final s =ref.watch(authStateNotifierProvider);
    // ref.listen(authStateNotifierProvider, (previous, authState) {
    //   authState.maybeMap(
    //     authenticated: (value) => routes.go("/dashboard"),
    //     unauthenticated: (value) => routes.go("/login"),
    //     orElse: () {},
    //   );
    // });

    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: primaryTheme,
      // home: const OnBoardScreen(),
    );
  }
}
