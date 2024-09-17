import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TAppbarTheme {
  TAppbarTheme._();

  static AppBarTheme appBarLightTheme = const AppBarTheme(
    elevation: 0.0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: TColors.black, size: 24),
    titleTextStyle: TextStyle(
      fontSize: TSizes.fontSizeMd,
      fontWeight: FontWeight.w600,
      color: TColors.black,
    ),
  );

  static AppBarTheme appBarDarkTheme = const AppBarTheme(
    elevation: 0.0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: TColors.white, size: 24),
    titleTextStyle: TextStyle(
      fontSize: TSizes.fontSizeMd,
      fontWeight: FontWeight.w600,
      color: TColors.white,
    ),
  );
}
