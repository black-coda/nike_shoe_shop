import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/login_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/register_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/reset_password.dart';
import 'package:nike_shoe_shop/src/features/onboardscreens/presentation/onboard_screen.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/dashboard.dart';
import 'package:nike_shoe_shop/src/routeManager/error_page_screen.dart';

class RouteManager {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const ErrorScreen(),
    // redirect: (context, state){

    // },
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
        path: "/dashboard",
        builder: (context, state) => const DashBoardView(),
      ),
      GoRoute(
        path: "/reset-password",
        builder: (context, state) => const PasswordResetWidget(),
      ),
    ],
  );
}

class RouterManager {}
