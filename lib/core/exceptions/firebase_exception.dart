class TFirebaseException implements Exception {
  final String code;
  TFirebaseException({required this.code});

  String get message {
    switch (code) {
      case 'claims-too-large':
        return 'The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.';
      case 'email-already-exists':
        return 'The provided email is already in use by an existing user. Each user must have a unique email.';
      case 'id-token-expired':
        return 'The provided Firebase ID token is expired.';
      case 'id-token-revoked':
        return 'The Firebase ID token has been revoked.';
      case 'insufficient-permission':
        return 'The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource.';
      case 'internal-error':
        return 'The Authentication server encountered an unexpected error while trying to process the request.';
      case 'invalid-argument':
        return 'An invalid argument was provided to an Authentication method.';
      case 'invalid-claims':
        return 'The custom claim attributes provided to setCustomUserClaims() are invalid.';
      case 'invalid-continue-uri':
        return 'The continue URL must be a valid URL string.';
      case 'invalid-creation-time':
        return 'The creation time must be a valid UTC date string.';
      case 'invalid-credential':
        return 'The credential used to authenticate the Admin SDKs cannot be used to perform the desired action.';
      case 'invalid-disabled-field':
        return 'The provided value for the disabled user property is invalid. It must be a boolean.';
      case 'invalid-display-name':
        return 'The provided value for the displayName user property is invalid. It must be a non-empty string.';
      case 'invalid-dynamic-link-domain':
        return 'The provided dynamic link domain is not configured or authorized for the current project.';
      case 'invalid-email':
        return 'The provided value for the email user property is invalid. It must be a string email address.';
      case 'invalid-email-verified':
        return 'The provided value for the emailVerified user property is invalid. It must be a boolean.';
      case 'invalid-hash-algorithm':
        return 'The hash algorithm must match one of the strings in the list of supported algorithms.';
      case 'invalid-hash-block-size':
        return 'The hash block size must be a valid number.';
    }
    return 'An undefined error occurred.';
  }
}
