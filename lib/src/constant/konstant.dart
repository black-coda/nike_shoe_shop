import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthKonstant {
  static const accountExistsWithDifferentCredential =
      'accounts-exists-with-different-credential';
  static const googleCom = "google.com";
  static const emailScope = "email";
  static const profileScope = "profile";
  static const defaultPhoto =
      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";

  const AuthKonstant._();
}
