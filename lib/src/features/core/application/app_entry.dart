import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/Theme/theme_.dart';
import 'package:nike_shoe_shop/src/routeManager/routes.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerDelegate: RouteManager.router.routerDelegate,
      // routeInformationParser: RouteManager.router.routeInformationParser,
      routerConfig: RouteManager.router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: primaryTheme,
      // home: const OnBoardScreen(),
    );
  }
}
