import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    required String password,
    // String display,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
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

