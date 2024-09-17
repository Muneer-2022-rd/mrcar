import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'color_methods/dark_method.dart';
import 'color_methods/light_method.dart';
import 'custome_theme/appbar_theme.dart';
import 'custome_theme/bottom_sheet_theme.dart';
import 'custome_theme/icon_button_theme.dart';
import 'custome_theme/outlined_button_theme.dart';
import 'custome_theme/text_button_theme.dart';
import 'custome_theme/text_theme.dart';

const Color primaryGreen = TColors.primaryGreen;
final ThemeData greenLightTheme = themeDataLight(primaryGreen);
final ThemeData greenDarkTheme = themeDataDark(primaryGreen);

const Color primaryBlue = TColors.primaryBlue;
final ThemeData blueLightTheme = themeDataLight(primaryBlue);
final ThemeData blueDarkTheme = themeDataDark(primaryBlue);

const Color primaryRed = TColors.primaryRed;
final ThemeData redLightTheme = themeDataLight(primaryRed);
final ThemeData redDarkTheme = themeDataDark(primaryRed);

const Color primaryYellow = TColors.primaryYellow;
final ThemeData yellowLightTheme = themeDataLight(primaryYellow);
final ThemeData yellowDarkTheme = themeDataDark(primaryYellow);

const Color primaryOrange = TColors.primaryOrange;
final ThemeData orangeLightTheme = themeDataLight(primaryOrange);
final ThemeData orangeDarkTheme = themeDataDark(primaryOrange);

const Color primaryPurple = TColors.primaryPurple;
final ThemeData purpleLightTheme = themeDataLight(primaryPurple);
final ThemeData purpleDarkTheme = themeDataDark(primaryPurple);

const Color primaryPink = TColors.primaryPink;
final ThemeData pinkLightTheme = themeDataLight(primaryPink);
final ThemeData pinkDarkTheme = themeDataDark(primaryPink);

final TextStyle headlineSmall = const TextStyle().copyWith(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: TColors.black,
);

ThemeData themeDataLight(Color mainColor) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: mainColor,
    scaffoldBackgroundColor: TColors.white,
    textTheme: TTextTheme.textLightTheme,
    elevatedButtonTheme: elevatedButtonThemeDataLightMethod(mainColor),
    appBarTheme: TAppbarTheme.appBarLightTheme,
    bottomSheetTheme: TButtomSheetTheme.bottomSheetLightTheme,
    checkboxTheme: checkboxThemeDataLightMethod(mainColor),
    chipTheme: chipThemeDataLightMethod(mainColor),
    outlinedButtonTheme: TOutlinedButtonTheme.outlinedButtonLightTheme,
    inputDecorationTheme: inputDecorationThemeLightMethod(mainColor, headlineSmall),
    textButtonTheme: TTextButtonTheme.lightTheme,
    dividerColor: TColors.grey,
    iconButtonTheme: TIconButtonTheme.iconButtonLightTheme,
    navigationBarTheme: navigationBarThemeDataLightMethod(mainColor),
    cardTheme: cardThemeLightMethod(mainColor),
  );
}

ThemeData themeDataDark(Color mainColor) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: mainColor,
    scaffoldBackgroundColor: TColors.black,
    textTheme: TTextTheme.textDarkTheme,
    elevatedButtonTheme: elevatedButtonThemeDataDarkMethod(mainColor),
    appBarTheme: TAppbarTheme.appBarDarkTheme,
    bottomSheetTheme: TButtomSheetTheme.bottomSheetDarkTheme,
    checkboxTheme: checkboxThemeDataDarkMethod(mainColor),
    chipTheme: chipThemeDataDarkMethod(mainColor),
    outlinedButtonTheme: TOutlinedButtonTheme.outlinedButtonDarkTheme,
    inputDecorationTheme: inputDecorationThemeDarkMethod(mainColor, headlineSmall),
    textButtonTheme: TTextButtonTheme.darkTheme,
    dividerColor: TColors.grey,
    iconButtonTheme: TIconButtonTheme.iconButtonDarkTheme,
    navigationBarTheme: navigationBarThemeDataDarkMethod(mainColor),
    cardTheme: cardThemeDarkMethod(mainColor),
  );
}
