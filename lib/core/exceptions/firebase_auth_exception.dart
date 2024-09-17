class TFirebaseAuthException implements Exception {
  final String code;
  TFirebaseAuthException({required this.code});

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'wrong-password':
        return 'The password is invalid for the given email, or the account corresponding to the email does not have a password set.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'user-not-found':
        return 'There is no user corresponding to the given email.';
      case 'operation-not-allowed':
        return 'The type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.';
      case 'weak-password':
        return 'The password is not strong enough.';
      case 'account-exists-with-different-credential':
        return 'There already exists an account with the email address asserted by the credential.';
      case 'invalid-credential':
        return 'The credential is malformed or has expired.';
      case 'too-many-requests':
        return 'Too many requests to sign-in. Please try again later.';
      case 'network-request-failed':
        return 'Network error has occurred, please try again.';
    }
    return 'An undefined error occurred.';
  }
}
