import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TOutlinedButtonTheme {
  static OutlinedButtonThemeData outlinedButtonLightTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.black,
      side: const BorderSide(color: TColors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      textStyle: const TextStyle(
        fontSize: TSizes.fontSizeMd,
        color: TColors.black,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: TSizes.md, horizontal: 20),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonDarkTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.white,
      side: const BorderSide(color: TColors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      textStyle: const TextStyle(
        fontSize: TSizes.fontSizeMd,
        color: TColors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: TSizes.md, horizontal: 20),
    ),
  );
}
