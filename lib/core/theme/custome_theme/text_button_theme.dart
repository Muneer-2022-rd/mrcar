import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TTextButtonTheme {
  static TextButtonThemeData lightTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.darkerGrey,
      textStyle: const TextStyle(
        fontSize: TSizes.fontSizeMd,
        // color: TColors.darkerGrey,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static TextButtonThemeData darkTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TColors.white,
      textStyle: const TextStyle(
        fontSize: TSizes.fontSizeLg,
        color: TColors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
