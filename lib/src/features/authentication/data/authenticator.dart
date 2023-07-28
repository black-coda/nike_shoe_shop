import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/constant/konstant.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_error.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_field_name.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/user_info_storage.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class Authenticator {
  final UserInfoStorage userInfoStorage;

  Authenticator({required this.userInfoStorage});

  //? General declaration
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //! Refresh

  Future<void> refresh() async{
    await auth.currentUser?.reload();
  }



  //* update user profile with stream
  Stream<Map<String, dynamic>> streamUpdateUserProfile() {
    final authId = auth.currentUser?.uid;
    return db
        .collection(FirebaseCollectionName.user)
        .doc(authId)
        .snapshots()
        .map(
          (snapshot) => snapshot.data() as Map<String, dynamic>,
        );
  }


  //
  //*update user profile
  Future<bool> updateUserProfile({
    required String newDisplayName,
    required String newEmail,
  }) async {
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      return false;
    }

    final authId = currentUser.uid;

    try {
      // Update the email and display name in Firebase Authentication
      await currentUser.updateEmail(newEmail);
      await currentUser.updateDisplayName(newDisplayName);

      // Update the user document in Firestore
      final userDocSnapshot = await db
          .collection(FirebaseCollectionName.user)
          .where(FirebaseCollectionName.user, isEqualTo: authId)
          .get();

      userDocSnapshot.log();

      if (userDocSnapshot.docs.isNotEmpty) {
        final userDocRef = userDocSnapshot.docs.first.reference;
        // userDocRef.
        await userDocRef.update({
          'displayName': newDisplayName,
          'email': newEmail,
        });

        //custom save
        saveUserInformation(
            userId: authId, displayName: newDisplayName, email: newEmail);
      }

      await auth.currentUser?.reload();

      return true;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserAuthChanges(UserId userId) async {
    final userProfileDetail =
        await db.collection(FirebaseCollectionName.user).doc(userId).get();

    if (userProfileDetail.exists) {
      return userProfileDetail.data() as Map<String, dynamic>;
    } else {
      return {} as Map<String, dynamic>;
    }
  }

  //? get current user information using Futures
  Future<Map<String, dynamic>?> getUserProfile() async {
    return getUserUID().then(
      (uid) async {
        if (uid != null) {
          final userProfile =
              await db.collection(FirebaseCollectionName.user).doc(uid).get();
          return userProfile.data();
        }
        return null;
      },
    );
  }

  // get user with stream
  Stream<Map<String, dynamic>> getUserProfileStream() async* {
    final uid = await getUserUID();

    final userSnapshot =
        db.collection(FirebaseCollectionName.user).doc(uid).get();
    final userdata = await userSnapshot;
    userdata.data().toString().log();
    yield userdata.data()!;
  }

  // get currently signed in user ID
  Future<UserId?> getUserUID() async => auth.currentUser?.uid;

  Future<bool> isSignedIn() async => getUserUID().then(
        (userId) => userId != null,
      );

  Future<String?> get email async {
    return auth.currentUser?.email;
  }

  Future<String?> get displayName async {
    return auth.currentUser?.displayName;
  }

  Future<void> authLogout() async {
    await auth.signOut();
    // await GoogleSignIn().signOut();
  }

  Future<Either<AuthFailure, Unit>> loginWithGoogleProvider() async {
    //? Create Google sign in object

    final GoogleSignIn googleLogin = GoogleSignIn(scopes: [
      AuthKonstant.emailScope,
      AuthKonstant.profileScope,
    ]);

    //?   Waits for the user to sign in with their Google account.
    final signInAccount = await googleLogin.signIn();

    //? if sign-in process is cancelled, it returns AuthFailure.error without message
    if (signInAccount == null) {
      return left(const AuthFailure.error());
    }

    //? Get Authentication data from logged in G-account
    final googleAuthData = await signInAccount.authentication;

    //? Uses the GoogleAuthProvider.credential method to create a OAuthCredential
    //? object
    //? with the access token and ID token from the authentication data.
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuthData.accessToken,
      idToken: googleAuthData.idToken,
    );

    try {
      final userCredential = await auth.signInWithCredential(oauthCredential);
      final email = userCredential.user!.email;
      final displayName = userCredential.user!.displayName;
      final UserId userId = userCredential.user!.uid;
      final photoUrl = userCredential.user!.photoURL;

      if (email != null && displayName != null) {
        await saveUserInformation(
          userId: userId,
          displayName: displayName,
          email: email,
          photoUrl: photoUrl,
        );
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
        AuthFailure.error(
          determineError(e),
        ),
      );
    }
  }

  //? Create user with email and password
  Future<Either<AuthFailure, Unit>> createUserWithEmailAndPassword(
      UserModel userModel) async {
    final auth = FirebaseAuth.instance;
    final email = userModel.email;
    final password = userModel.password;
    final displayName = userModel.displayName;

    try {
      final UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = cred.user!.uid;
      final user = cred.user;

      if (cred.user?.uid != null && user != null) {
        await saveUserInformation(
          userId: userId,
          displayName: displayName,
          email: email,
        );

        await user.updateDisplayName(displayName);
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
        AuthFailure.error(
          determineError(e),
        ),
      );
    }
  }

  //* save user information
  Future<void> saveUserInformation({
    required UserId userId,
    required String displayName,
    required String email,
    String? photoUrl,
  }) {
    return userInfoStorage.saveUserInformation(
      userId: userId,
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
    );
  }

  //? sign in with email and password
  Future<Either<AuthFailure, Unit>> loginUserWithEmailAndPassword(
      UserModel userModel) async {
    final auth = FirebaseAuth.instance;
    final email = userModel.email;
    final password = userModel.password;

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
        AuthFailure.error(
          determineError(e),
        ),
      );
    }
  }

  //? Logout Functionality
  Future<void> logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  //? Send a password reset email

  Future<Either<AuthFailure, Unit>> passwordResetEmail(String email) async {
    final auth = FirebaseAuth.instance;

    try {
      auth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      e.log();
      return left(AuthFailure.error(e.toString()));
    }
  }
}
