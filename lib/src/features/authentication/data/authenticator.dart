import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/constant/konstant.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_error.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
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


  //*update user profile

  Future<bool> updateUserProfile({
    required String newDisplayName,
    required String newEmail,
  }) async {
    //TODO: to create if
    final authId = auth.currentUser!.uid;
    final displayName = auth.currentUser!.displayName;
    final dbId = await db
        .collection(FirebaseCollectionName.user)
        .where(FirebaseCollectionName.user, isEqualTo: authId)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          await auth.currentUser!.updateEmail(newEmail);
          await auth.currentUser!.updateDisplayName(displayName);
          return true;
        }
      },
    );

    return dbId ?? false;
  }

  //? get current user information

  Future<Map<String, dynamic>?> getUserProfile() async => getUserUID().then(
        (uid) async {
          if (uid != null) {
            final displayName = auth.currentUser?.displayName;
            final userProfile = await db
                .collection(FirebaseCollectionName.user)
                .doc(displayName)
                .get();
            return userProfile.data();
          }
          return null;
        },
      );

  // get currently signed in user ID
  Future<UserId?> getUserUID() async => auth.currentUser?.uid;

  Future<bool> isSignedIn() async => getUserUID().then(
        (userId) => userId != null,
      );

  Future<String?> get email async {
    debugPrint(auth.currentUser?.email);

    return auth.currentUser?.email;
  }

  Future<String?> get displayName async {
    debugPrint(auth.currentUser?.displayName);
    auth.currentUser?.displayName?.log();
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

      debugPrint("here 😪😪😪😪👨‍🍳");

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

    displayName.log();

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
