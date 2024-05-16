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
      static const defaultBannerShoe = "https://images.unsplash.com/photo-1608231387042-66d1773070a5?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  const AuthKonstant._();
}
