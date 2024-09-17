import 'package:flutter/material.dart';

import 'theme_color.dart';

enum AppTheme {
  blueLight,
  blueDark,

  greenLight,
  greenDark,

  redLight,
  redDark,

  yellowLight,
  yellowDark,

  purpleLight,
  purpleDark,

  orangeLight,
  orangeDark,

  pinkLight,
  pinkDark,
}

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.blueLight: blueLightTheme,
  AppTheme.blueDark: blueDarkTheme,
  AppTheme.redLight: redLightTheme,
  AppTheme.redDark: redDarkTheme,
  AppTheme.greenLight: greenLightTheme,
  AppTheme.greenDark: greenDarkTheme,
  AppTheme.yellowLight: yellowLightTheme,
  AppTheme.yellowDark: yellowDarkTheme,
  AppTheme.purpleLight: purpleLightTheme,
  AppTheme.purpleDark: purpleDarkTheme,
  AppTheme.orangeLight: orangeLightTheme,
  AppTheme.orangeDark: orangeDarkTheme,
  AppTheme.pinkLight: pinkLightTheme,
  AppTheme.pinkDark: pinkDarkTheme,
};
