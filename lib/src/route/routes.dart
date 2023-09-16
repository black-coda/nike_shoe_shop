import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/edit_profile.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/login_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/profile_screen.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/register_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/reset_password.dart';
import 'package:nike_shoe_shop/src/features/onboardscreens/presentation/onboard_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/nav_bar/bottom_navbar_scaffold.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/favorite_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/notification_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product_details.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product_list.dart';
import 'package:nike_shoe_shop/src/route/error_page_screen.dart';

class RouteManager {
  static final GlobalKey<NavigatorState> _rootNavigator =
      GlobalKey(debugLabel: "root");
  static final GlobalKey<NavigatorState> _shellNavigator =
      GlobalKey(debugLabel: "shell");

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (context, state) => const OnBoardScreen(),
      ),

      //? Auth Route
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: "/reset-password",
        builder: (context, state) => const PasswordResetWidget(),
      ),

      //? Bottom Navigation bar route
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(
            child,
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            name: "productList",
            path: '/productList',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ProductListScreen(
                key: state.pageKey,
              ),
            ),
            routes: [
              GoRoute(
                path: "productDetail/:productId",
                name: "productDetail",
                parentNavigatorKey: _rootNavigator,
                pageBuilder: (context, state) => NoTransitionPage(
                  
                  child: ProductDetailScreen(
                    key: state.pageKey,
                    productID: state.pathParameters["productId"]!,
                  ),
                ),
              )
            ],
          ),
          GoRoute(
            name: "profile",
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              child: UserProfileScreen(
                key: state.pageKey,
              ),
            ),

            //* Sub routes for BottomNavBar profile
            routes: [
              GoRoute(
                path: "editProfile",
                name: "editedProfile",
                parentNavigatorKey: _rootNavigator,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: UpdateProfile(
                    key: state.pageKey,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            name: "favorite",
            path: '/favorite',
            pageBuilder: (context, state) => NoTransitionPage(
              child: FavoriteScreen(
                key: state.pageKey,
              ),
            ),

            
          ),
          GoRoute(
            name: "notification",
            path: '/notification',
            pageBuilder: (context, state) => NoTransitionPage(
              child: NotificationScreen(
                key: state.pageKey,
              ),
            ),
          ),
        ],
      )
    ],
  );
}
