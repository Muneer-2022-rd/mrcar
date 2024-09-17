import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TIconButtonTheme {
  static IconButtonThemeData iconButtonLightTheme = const IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStatePropertyAll(TColors.black)));
  static IconButtonThemeData iconButtonDarkTheme = const IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStatePropertyAll(TColors.white)));
}
