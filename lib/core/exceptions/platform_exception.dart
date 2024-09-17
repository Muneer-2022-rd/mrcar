class TPlatformException implements Exception {
  final String code;
  TPlatformException({required this.code});

  String get message {
    switch (code) {
      case 'sign_in_canceled':
        return 'The sign in process was cancelled.';
      case 'sign_in_failed':
        return 'Sign in failed. Please check your credentials.';
      case 'user-not-found':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'channel-error':
        return 'Unable to establish connection on channel.';
      case 'unexpected-security-result':
        return 'Unexpected security result code.';
    }
    return 'An undefined error occurred.';
  }
}
