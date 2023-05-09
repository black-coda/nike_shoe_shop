import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_error.dart';
part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.error([AuthError? message]) = _Error;
}
