import 'package:firebase_auth/firebase_auth.dart';

enum AuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  error,
}

AuthError determineError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return AuthError.invalidEmail;
    case 'user-disabled':
      return AuthError.userDisabled;
    case 'user-not-found':
      return AuthError.userNotFound;
    case 'wrong-password':
      return AuthError.wrongPassword;
    case 'email-already-in-use':
    case 'account-exists-with-different-credential':
      return AuthError.emailAlreadyInUse;
    case 'invalid-credential':
      return AuthError.invalidCredential;
    case 'operation-not-allowed':
      return AuthError.operationNotAllowed;
    case 'weak-password':
      return AuthError.weakPassword;
    case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
    default:
      return AuthError.error;
  }
}
