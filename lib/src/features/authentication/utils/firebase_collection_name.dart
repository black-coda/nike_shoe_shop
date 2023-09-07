import "package:flutter/foundation.dart" show immutable;

@immutable
class FirebaseCollectionName {
  static const user = "users";
  static const product = "product";
  static const thumbNail = "thumbNail";
  static const order ="order";
  static const cart ="cart";
  static const favorite ="favorite";

  const FirebaseCollectionName._();
}
