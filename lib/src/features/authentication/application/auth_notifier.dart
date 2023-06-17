import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/user_info_storage.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial({@Default(false) bool isLoading}) = _Initial;
  const factory AuthState.authenticated({@Default(false) bool isLoading}) =
      _Authenticated;
  const factory AuthState.unauthenticated({@Default(false) bool isLoading}) =
      _Unauthenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
  const factory AuthState.isLoading() = _IsLoading;
}



class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator authenticator;
 
  AuthStateNotifier({
    required this.authenticator,
   
  }) : super(const AuthState.initial());

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

    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Logging In")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lottie/97204-loader.json"),
              const SizedBox(height: 16),
              const Text("Please wait..."),
            ],
          ),
        );
      },
    );

    await authenticator.loginUserWithEmailAndPassword(userModel).then(
      (authState) {
        //? Close the loading dialog
        Navigator.of(context).pop();

        //? Declare state using dartz
        state = authState.fold(
          (failure) {
            showDialog(
              context: context,
              //? Prevent dismissing the dialog by tapping outside
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text(
                      failure.message!,
                      style: const TextStyle(
                        color: Color(0xffe3342f),
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset("assets/lottie/41791-loading-wrong.json"),
                      const SizedBox(height: 16),
                      const Text("Oops...😪"),
                    ],
                  ),
                );
              },
            );
            state.log();
            return AuthState.failure(failure);
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
                      const Text("Please wait..."),
                    ],
                  ),
                );
              },
            );

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

  //todo: Check if it works

  Future<void> sendPasswordResetEmail(String email, context) async {
    state = const AuthState.unauthenticated();
    final successOrFail = await authenticator.passwordResetEmail(email);

    successOrFail.fold(
      (failCase) {
        showDialog(
          context: context,
          barrierDismissible:
              true, // Prevent dismissing the dialog by tapping outside
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                  child: Text(
                failCase.message!,
                style: const TextStyle(
                  color: Color(0xffe3342f),
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("assets/lottie/41791-loading-wrong.json"),
                  const SizedBox(height: 16),
                  const Text("Oopsss...😪"),
                ],
              ),
            );
          },
        );
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
