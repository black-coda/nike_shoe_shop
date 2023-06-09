import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/login_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/register_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/reset_password.dart';
import 'package:nike_shoe_shop/src/features/onboardscreens/presentation/onboard_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/dashboard.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/favorite_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/notification_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product_list.dart';
import 'package:nike_shoe_shop/src/features/profile/presentation/widgets/profile_screen.dart';
import 'package:nike_shoe_shop/src/route/error_page_screen.dart';

class RouteManager {
  static final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey(debugLabel: "root");
  static final GlobalKey<NavigatorState> _shellNavigator =
      GlobalKey(debugLabel: "shell ");

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (context, state) => const OnBoardScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: "/test",
        builder: (context, state) => const HomiePae(),
      ),

      GoRoute(
        path: "/reset-password",
        builder: (context, state) => const PasswordResetWidget(),
      ),

      //? Bottom Navigation bar route
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) {
          return DashBoardScreen(
            child,
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            name: "productList",
            path: '/productList',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const ProductListScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            name: "profile",
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const ProfileScreen(),
              key: state.pageKey,
            ),

          ),
          GoRoute(
            name: "favorite",
            path: '/favorite',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const FavoriteScreen(),
              key: state.pageKey,
            ),
          ),
          GoRoute(
            name: "notification",
            path: '/notification',
            pageBuilder: (context, state) => NoTransitionPage(
              child: const NotificationScreen(),
              key: state.pageKey,
            ),
          ),
        ],
      )
    ],
  );
}



