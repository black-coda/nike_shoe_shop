import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nike_shoe_shop/src/features/onboardscreens/presentation/onboard_screen.dart';
import 'firebase_options.dart';
import 'src/Theme/theme_.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppEntry());
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerDelegate: _router.routerDelegate,
      // routeInformationParser: _router.routeInformationParser,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: primaryTheme,
      // home: const OnBoardScreen(),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const OnBoardScreen(),
    )
  ],
);
