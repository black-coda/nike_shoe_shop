import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/application/auth_notifier.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/routeManager/routes.dart';

final authenticatorProvider = Provider<Authenticator>((ref) {
  return Authenticator();
});

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref.watch(authenticatorProvider));
});

final isSignedInProvider = FutureProvider((ref) async {
  final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
  await authStateNotifier.checkAndUpdateAuthState();
});


final goRouterProvider = Provider<GoRouter>((ref) {
  return RouteManager.router;
});