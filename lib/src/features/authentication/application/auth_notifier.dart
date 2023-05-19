import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/src/features/authentication/data/authenticator.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  // const factory AuthState() = _AuthState;
  const factory AuthState.initial({@Default(false) bool isLoading}) = _Initial;
  const factory AuthState.authenticated({@Default(false) bool isLoading}) =
      _Authenticated;
  const factory AuthState.unauthenticated({@Default(false) bool isLoading}) =
      _Unauthenticated;
  const factory AuthState.failure(AuthFailure failure,
      {@Default(false) bool isLoading}) = _Failure;
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
      (failure) => AuthState.failure(failure),
      (success) => const AuthState.authenticated(),
    );
  }

  //? create account With email
  Future<void> createUserWithEmailAndPassword(UserModel userModel) async {
    final failureOrSuccess =
        await _authenticator.createUserWithEmailAndPassword(userModel);

    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure),
      (success) => const AuthState.authenticated(),
    );
  }

  //? create account With email
  Future<void> loginUserWithEmailAndPassword(UserModel userModel) async {
    final failureOrSuccess =
        await _authenticator.createUserWithEmailAndPassword(userModel);

    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure),
      (success) => const AuthState.authenticated(),
    );
  }

  Future<void> logoutUser() async {
    await _authenticator.logOut();
    state = const AuthState.authenticated();
  }
}
