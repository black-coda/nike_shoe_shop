import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/application/auth_notifier.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/user_info_storage.dart';
import 'package:nike_shoe_shop/src/route/routes.dart';

final authenticatorProvider = Provider<Authenticator>((ref) {
  final userInfoStorage = ref.watch(firebaseInformationProvider);
  return Authenticator(
    userInfoStorage: userInfoStorage,
  );
});

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authenticateProvider = ref.watch(authenticatorProvider);

  return AuthStateNotifier(
    authenticator: authenticateProvider,
  );
});

final isSignedInProvider = FutureProvider((ref) async {
  final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
  await authStateNotifier.checkAndUpdateAuthState();
});

final goRouterProvider = Provider<GoRouter>((ref) {
  return RouteManager.router;
});

//* Firebase information

final firebaseInformationProvider = Provider<UserInfoStorage>((ref) {
  return UserInfoStorage();
});
