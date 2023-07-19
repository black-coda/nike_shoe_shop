import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/dialogs.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
  const factory AuthState.isLoading() = _IsLoading;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator authenticator;

  AuthStateNotifier({
    required this.authenticator,
  }) : super(const AuthState.initial());

  //? update user profile

  Future<void> updateUserProfile({
    required String newDisplayName,
    required String newEmail,
    
  }) async {
    //TODO: Continue from here
    await authenticator.updateUserProfile(
      newDisplayName: newDisplayName,
      newEmail: newEmail,
    );
  }

  //? Get users profile detail
  Future<Map<String, dynamic>?> getUserProfile() async {
    return authenticator.getUserProfile();
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
    state.log();

    DialogScreen.loaderDialog(context);

    await authenticator.loginUserWithEmailAndPassword(userModel).then(
      (authState) {
        //? Close the loading dialog
        Navigator.of(context).pop();

        //? Declare state using dartz
        state = authState.fold(
          (failCase) {
            debugPrint("${state.toString()} debug");
            DialogScreen.errorDialog(context, failCase);
            state.log();
            return AuthState.failure(failCase);
          },
          (success) {
            debugPrint("${state.toString()} debug");
            DialogScreen.successDialog(context, success);

            Future.delayed(const Duration(seconds: 3), () {});

            state.log();

            return const AuthState.authenticated();
          },
        );
      },
    );

    state.toString().log();
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
