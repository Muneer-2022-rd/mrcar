class TFormatException implements Exception {
  final String code;
  TFormatException({required this.code});

  String get message {
    switch (code) {
      case 'invalid-string':
        return 'The string does not conform to the required pattern.';
      case 'invalid-datetime':
        return 'The DateTime string does not conform to the expected culture-specific formatting patterns.';
      case 'invalid-guid':
        return 'The GUID string is not 32-hexadecimal digits.';
      case 'invalid-boolean':
        return 'The Boolean string is not "True", "true", "False", or "false".';
      case 'invalid-format':
        return 'The format of an argument is invalid, or a composite format string is not well formed.';
      case 'invalid-number':
        return 'The number string does not conform to the expected format.';
    }
    return 'An undefined error occurred.';
  }
}
