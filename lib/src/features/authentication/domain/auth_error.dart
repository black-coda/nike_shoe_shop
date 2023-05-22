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

List<String> authError = [
  "Invalid email address",
  "User Disabled",
  "User account not found",
  "Invalid Password or email address",
  "email already in use or account exist with different credential",
  "Invalid Credential",
  "Operation Not Allowed",
  "Weak password",
  "auth_error"
];



Map<String, String> authenticationError = {
  'invalid-email': 'Invalid email address',
  'user-disabled': 'User Disabled',
  'user-not-found': 'User account not found',
  'wrong-password': 'Invalid Password or email address',
  'email-already-in-use': 'Email already in use or account exists with different credentials',
  'invalid-credential': 'Invalid Credential',
  'operation-not-allowed': 'Operation Not Allowed',
  'weak-password': 'Weak password',
  'default': 'Authentication error',
};

String determineError(FirebaseAuthException exception) {
  return authenticationError[exception.code] ?? authenticationError['default']!;
}





//   _determineError(FirebaseAuthException exception) {
//   switch (exception.code) {
//     case value:
      
//       break;
//     default:
//   }
// }


// AuthError determineError(FirebaseAuthException exception) {
//   switch (exception.code) {
//     case 'invalid-email':
//       return AuthError.invalidEmail;
//     case 'user-disabled':
//       return AuthError.userDisabled;
//     case 'user-not-found':
//       return AuthError.userNotFound;
//     case 'wrong-password':
//       return AuthError.wrongPassword;
//     case 'email-already-in-use':
//     case 'account-exists-with-different-credential':
//       return AuthError.emailAlreadyInUse;
//     case 'invalid-credential':
//       return AuthError.invalidCredential;
//     case 'operation-not-allowed':
//       return AuthError.operationNotAllowed;
//     case 'weak-password':
//       return AuthError.weakPassword;
//     case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
//     default:
//       return AuthError.error;
//   }
// }
