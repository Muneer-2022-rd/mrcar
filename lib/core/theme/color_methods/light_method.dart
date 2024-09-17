import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

CardTheme cardThemeLightMethod(Color color) {
  return CardTheme(
    color: color.withOpacity(0.3),
    elevation: 0,
  );
}

NavigationBarThemeData navigationBarThemeDataLightMethod(Color color) {
  return NavigationBarThemeData(
    backgroundColor: color.withOpacity(0.1),
    indicatorColor: color.withOpacity(0.3),
  );
}

InputDecorationTheme inputDecorationThemeLightMethod(
  Color color,
  TextStyle textStyle,
) {
  return InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.black38,
    suffixIconColor: Colors.black38,
    fillColor: TColors.grey,
    filled: false,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: TColors.grey, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: TColors.grey, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: color, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: TColors.error, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: TColors.warning, width: 2.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(color: TColors.grey, width: 1.0),
    ),
    hintStyle: textStyle,
    errorStyle: textStyle.copyWith(color: Colors.red),
    labelStyle: textStyle,
    helperStyle: textStyle,
    prefixStyle: textStyle,
    suffixStyle: textStyle,
    counterStyle: textStyle,
    floatingLabelStyle: const TextStyle().copyWith(
      color: color.withOpacity(0.8),
    ),
  );
}

ChipThemeData chipThemeDataLightMethod(Color color) {
  return ChipThemeData(
      selectedColor: color,
      disabledColor: TColors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(
        color: TColors.black,
      ),
      padding: const EdgeInsets.all(12.0),
      checkmarkColor: TColors.white);
}

CheckboxThemeData checkboxThemeDataLightMethod(Color color) {
  return CheckboxThemeData(
    side: const BorderSide(color: Colors.black38),
    visualDensity: VisualDensity.comfortable,
    checkColor: const WidgetStatePropertyAll(Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  );
}

ElevatedButtonThemeData elevatedButtonThemeDataLightMethod(Color color) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.white,
      backgroundColor: color,
      disabledBackgroundColor: TColors.grey,
      disabledForegroundColor: TColors.grey,
      side: BorderSide(color: color),
      padding: const EdgeInsets.symmetric(vertical: TSizes.md),
      textStyle: const TextStyle(
        fontSize: TSizes.fontSizeLg,
        color: TColors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
      ),
    ),
  );
}
