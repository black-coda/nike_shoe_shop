import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
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
  final Authenticator _authenticator;
  AuthStateNotifier(this._authenticator) : super(const AuthState.initial());

  String getErrorMessage(AuthFailure failure) {
    return failure.when(
      error: (message) => message ?? "Authentication error",
    );
  }

  Future<void> checkAndUpdateAuthState() async {
    state = await _authenticator.isSignedIn()
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  //? login in with google
  Future<void> loginWithGoogle(context) async {
    final failureOrSuccess = await _authenticator.loginWithGoogleProvider();

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
        await _authenticator.createUserWithEmailAndPassword(userModel);

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

    // state.maybeMap(

    //   orElse: () async {
    //     final failureOrSuccess =
    //     await _authenticator.loginUserWithEmailAndPassword(userModel);
    //     state = failureOrSuccess.fold((l) => null, (r) => null);
    //   },
    // );`

    // ScaffoldMessenger.of(context).showMaterialBanner(materialBanner)
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(failure.message.toString()),
    //     duration: const Duration(seconds: 2),
    //   ),
    // );

    // customDialog(context, state);

    // Show SnackBar with error message
    // final a =loginScaffold.currentState?.showSnackBar(
    //   SnackBar(
    //     content: Text(failure.toString()),
    //     duration: const Duration(seconds: 2),
    //   ),
    // );
    // _registrationScaffold.currentState

    await _authenticator
        .loginUserWithEmailAndPassword(userModel)
        .then((authState) {
      Navigator.of(context).pop(); // Close the loading dialog
      state = authState.fold(
        (failure) {
          //!TODO: To Build custom error and success message

          showDialog(
            context: context,
            barrierDismissible:
                true, // Prevent dismissing the dialog by tapping outside
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text(failure.message!)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset("assets/lottie/41791-loading-wrong.json"),
                    const SizedBox(height: 16),
                    const Text("Please wait..."),
                  ],
                ),
              );
            },
          );
          state.log();
          return AuthState.failure(failure);
        },
        (success) {
          debugPrint("statement");
          // context.go("/dashboard");
          showDialog(
            context: context,
            barrierDismissible:
                true, // Prevent dismissing the dialog by tapping outside
            builder: (BuildContext context) {
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
          state.log();
          state.log();
          return const AuthState.authenticated();
        },
      );
    });

    state.toString().log();
  }

  Future<void> logoutUser() async {
    state = const AuthState.isLoading();
    await _authenticator.logOut();
    state = const AuthState.unauthenticated();
  }
}
