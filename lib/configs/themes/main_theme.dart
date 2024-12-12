import 'package:flutter/material.dart';

class MainTheme {

  static const Color primaryColor01 = Color(0xFFFFEADD);
  static const Color primaryColor02 = Color(0xFFFFEADD);
  static const Color primaryColor03 = Color(0xFFFCAEAE);
  static const Color primaryColor04 = Color(0xFFFF8989);
  static const Color primaryColor05 = Color(0xFFFF6666);

  static const Color textContrast01 = Colors.redAccent;

  static const Color inversePrimary = Colors.redAccent;

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor01,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor01,
        primary: primaryColor01,
        secondary: primaryColor02,
        onPrimary: textContrast01,
        inversePrimary: primaryColor04,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textContrast01),
        bodyMedium: TextStyle(color: textContrast01),
        headlineLarge: TextStyle(color: textContrast01),
        headlineMedium: TextStyle(color: textContrast01),
        headlineSmall: TextStyle(color: textContrast01),
        titleLarge: TextStyle(color: textContrast01),
        titleMedium: TextStyle(color: textContrast01),
        titleSmall: TextStyle(color: textContrast01),
        labelLarge: TextStyle(color: textContrast01),
        labelMedium: TextStyle(color: textContrast01),
        labelSmall: TextStyle(color: textContrast01),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor03,
        textTheme: ButtonTextTheme.primary,
      ),
      // Add other theme properties as needed
    );
  }
}