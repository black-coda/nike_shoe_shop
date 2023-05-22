import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  // const factory AuthState() = _AuthState;
  const factory AuthState.initial({@Default(false) bool isLoading}) = _Initial;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator _authenticator;
  AuthStateNotifier(this._authenticator) : super(const AuthState.initial());

  Future<void> checkAndUpdateAuthState() async {
    state = await _authenticator.isSignedIn()
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  //? login in with google

  Future<void> loginWithGoogle() async {
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
        // context.go('/dashboard');
        return const AuthState.authenticated();
      },
    );
  }

  //? create account With email
  Future<void> loginUserWithEmailAndPassword(
      UserModel userModel, context) async {
    final failureOrSuccess =
        await _authenticator.loginUserWithEmailAndPassword(userModel);

    state = failureOrSuccess.fold(
      (failure) {
        //!TODO: To Build custom error and success message
        // ScaffoldMessenger.of(context).showMaterialBanner(materialBanner)
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(failure.message.toString()),
        //     duration: const Duration(seconds: 2),
        //   ),
        // );
    

        showGeneralDialog(
          context: context,
          barrierLabel: "warning",
          barrierDismissible: true,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 30),
                    blurRadius: 60,
                  ),
                  const BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 30),
                    blurRadius: 60,
                  ),
                ],
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Text(
                      failure.message.toString(),
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            );
          },
        );

        // Show SnackBar with error message
        // final a =loginScaffold.currentState?.showSnackBar(
        //   SnackBar(
        //     content: Text(failure.toString()),
        //     duration: const Duration(seconds: 2),
        //   ),
        // );
        // _registrationScaffold.currentState
        return AuthState.failure(failure);
      },
      (success) {
        debugPrint("statement");
        // context.go("/dashboard");
        state.log();
        return const AuthState.authenticated();
      },
    );
    state.toString().log();
  }

  Future<void> logoutUser() async {
    await _authenticator.logOut();
    state = const AuthState.unauthenticated();
  }
}
