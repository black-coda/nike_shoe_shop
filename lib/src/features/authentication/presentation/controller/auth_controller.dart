import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/application/auth_notifier.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/user_info_storage.dart';
import 'package:nike_shoe_shop/src/route/routes.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

final authChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final authChangesFutureProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {

  final user = ref.watch(authChangesProvider).value;
  final authStateNotifier = ref.watch(authStateNotifierProvider.notifier);
  if (user != null) {
    final userProfileData = await ref
        .watch(authStateNotifierProvider.notifier)
        .getUserAuthChanges(user.uid);
    return userProfileData;
  } else {
    return null;
  }
});

final userprofileStreamProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final authProvider =
      ref.watch(authStateNotifierProvider.notifier).streamUpdateUserProfile();
  return authProvider;
});

final getUserProfileProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return ref
      .watch(authStateNotifierProvider.notifier)
      .getUserProfileUsingStream();
});

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

//? User Profile
final userProfileProvider =
    FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  final authStateNotifier = ref.watch(authStateNotifierProvider.notifier);
  final displayName = await authStateNotifier.displayName;

  final userProfileDetails = await authStateNotifier.getUserProfile();
  return userProfileDetails;
});
