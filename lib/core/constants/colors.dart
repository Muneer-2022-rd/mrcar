import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class TColors {
  // Private Constractor
  TColors._();
  // App Basic Colors
  static const Color primaryBlue = Color(0xff4B68FF);
  static const Color primaryRed = Color(0xffFF6B6B);
  static const Color primaryOrange = Color.fromARGB(255, 255, 161, 107);
  static const Color primaryYellow = Color(0xffFFD93D);
  static const Color primaryGreen = Color(0xff6BCB77);
  static const Color primaryPurple = Color(0xff9B51E0);
  static const Color primaryPink = Color.fromARGB(255, 224, 81, 205);
  // Linear Gradient Color
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );
  // Text Colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondry = Color(0xff6C757D);
  static const Color textWhite = Colors.white;
  // Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);
  // Background Container Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = TColors.white.withOpacity(0.1);
  // Button Colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondry = Color(0xff6C757D);
  static const Color buttonDisable = Color(0xffC4C4C4);
  // Border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondry = Color(0xffe6e6e6);
  // Error and Validation Colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);
  // Neutral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  static final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
}
