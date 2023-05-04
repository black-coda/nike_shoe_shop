import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/login_widget.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/register_widget.dart';
import 'package:nike_shoe_shop/src/features/onboardscreens/presentation/onboard_screen.dart';

class RouteManager {
  static final GoRouter router = GoRouter(
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
        builder: (context, state) => const RegistrationView(),
      ),
    ],
  );
}
