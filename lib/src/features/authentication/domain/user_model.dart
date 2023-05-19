import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

//* General declaration
final user = FirebaseAuth.instance.currentUser;

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    required String email,
    required String password,
   required String displayName,

    // String display,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserAuthModel with _$UserAuthModel {
  const factory UserAuthModel({
    required String email,
    required String password,
  }) = _UserAuthModel;
}

// Future<UserEntity?> signInWithEmailAndPassword({
//   required String email,
//   required String password,
// }) async {
//   try {
//     final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     return _mapFirebaseUser(userCredential.user);
//   } on auth.FirebaseAuthException catch (e) {
//     throw _determineError(e);
//   }
// }

// @override
// Future<UserEntity?> createUserWithEmailAndPassword({
//   required String email,
//   required String password,
// }) async {
//   try {
//     final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     return _mapFirebaseUser(_firebaseAuth.currentUser);
//   } on auth.FirebaseAuthException catch (e) {
//     throw _determineError(e);
//   }
// }



// UserModel fireBaseUserToUserModel(User ?user){
//   if(user != null){
//     return UserModel(email: user.email!, uid: user.uid!, password: user. )
//   }

// }