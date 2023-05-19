import 'package:nike_shoe_shop/src/constant/konstant.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_error.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authenticator {
  Authenticator();

  //* General declaration
  final auth = FirebaseAuth.instance;

  // get currently signed in user ID
  Future<UserId?> getUserCredential() async => auth.currentUser?.uid;

  Future<bool> isSignedIn() async => getUserCredential().then(
        (userId) => userId != null,
      );

  Future<String?> get email async => auth.currentUser?.email;

  Future<void> authLogout() async {
    await auth.signOut();
    // await GoogleSignIn().signOut();
  }

  Future<Either<AuthFailure, Unit>> loginWithGoogleProvider() async {
    //* Create Google sign in object

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
      await auth.signInWithCredential(oauthCredential);
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
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user?.uid != null) {
        await firestore.collection("users").doc(cred.user!.uid).set(
          {
            "email": email,
            "displayName": displayName,
            "address": "",
            "mobileNumber": '',
            "cart": [],
          },
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
}
