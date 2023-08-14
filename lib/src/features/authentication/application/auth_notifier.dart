import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/dialogs.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();



  const factory AuthState.authenticated() = _Authenticated;

  const factory AuthState.unauthenticated() = _Unauthenticated;

  const factory AuthState.failure(AuthFailure failure) = _Failure;

  const factory AuthState.isLoading() = _IsLoading;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator authenticator;

  AuthStateNotifier({
    required this.authenticator,
  }) : super(const AuthState.unauthenticated());

  //! Productive
  Future<void> upload() async => await authenticator.uploadJsonToFirestore();

  //! new
  Future<Map<String, dynamic>> getUserAuthChanges(UserId userId) async {
    return authenticator.getUserAuthChanges(userId);
  }

  //! refresh
  Future<void> refresh() => authenticator.refresh();
  //? update user profile with stream
  Stream<Map<String, dynamic>> streamUpdateUserProfile() {
    return authenticator.streamUpdateUserProfile();
  }

  //? update user profile
  Future<void> updateUserProfile({
    required String newDisplayName,
    required String newEmail,
    required BuildContext context,
  }) async {
    await authenticator
        .updateUserProfile(
      newDisplayName: newDisplayName,
      newEmail: newEmail,
    )
        .then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value
                ? "Update Successful 🚀, see result after you logout ✅"
                : "update profile not successful 😪"),
          ),
        );
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        );
      },
    );
  }

  //? Get users profile detail
  Future<Map<String, dynamic>?> getUserProfile() =>
      authenticator.getUserProfile();

  //? get user profile using stream
  Stream<Map<String, dynamic>> getUserProfileUsingStream() {
    return authenticator.getUserProfileStream();
  }

  String getErrorMessage(AuthFailure failure) {
    return failure.when(
      error: (message) => message ?? "Authentication error",
    );
  }

  Future<String?> get email async => await authenticator.email;

  Future<String?> get displayName async => await authenticator.displayName;

  Future<bool> checkSignedIn() async {
    return authenticator.isSignedIn();
  }

  Future<void> checkAndUpdateAuthState() async {
    state = await authenticator.isSignedIn()
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  //? login in with google
  Future<void> loginWithGoogle(context) async {
    final failureOrSuccess = await authenticator.loginWithGoogleProvider();

    state = failureOrSuccess.fold(
      (failure) {
        return AuthState.failure(failure);
      },
      (success) => const AuthState.authenticated(),
    );
  }

  //? create account With email
  Future<void> createUserWithEmailAndPassword(
      UserModel userModel, context) async {
    final failureOrSuccess =
        await authenticator.createUserWithEmailAndPassword(userModel);

    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure),
      (success) {
        return const AuthState.authenticated();
      },
    );
  }

  //? sign in user With email
  Future<void> loginUserWithEmailAndPassword(
      UserModel userModel, context) async {
    //? Implementation
    state = const AuthState.isLoading();

    DialogScreen.loaderDialog(context);

    await authenticator.loginUserWithEmailAndPassword(userModel).then(
      (authState) {
        //? Close the loading dialog
        Navigator.of(context).pop();

        //? Declare state using dartz
        state = authState.fold(
          (failCase) {
            DialogScreen.errorDialog(context, failCase);
            return AuthState.failure(failCase);
          },
          (success) {
            DialogScreen.successDialog(context, success);

            Future.delayed(const Duration(seconds: 3), () {});

            return const AuthState.authenticated();
          },
        );
      },
    );
  }

  //? Logout user

  Future<void> logoutUser() async {
    state = const AuthState.isLoading();
    await authenticator.logOut();
    state = const AuthState.unauthenticated();
  }

  //? Send user password reset email

  //TODO: Check if it works

  Future<void> sendPasswordResetEmail(String email, context) async {
    state = const AuthState.unauthenticated();
    final successOrFail = await authenticator.passwordResetEmail(email);

    successOrFail.fold(
      (failCase) {
        DialogScreen.errorDialog(context, failCase);
        return AuthState.failure(failCase);
      },
      (success) {
        showDialog(
          context: context,
          barrierDismissible:
              true, // Prevent dismissing the dialog by tapping outside
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(success.toString())),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("assets/lottie/41793-correct.json"),
                  const SizedBox(height: 16),
                  const Text("Check your email 🚀"),
                ],
              ),
            );
          },
        );
        return "";
      },
    );
  }
}
