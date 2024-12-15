import 'package:flutter/material.dart';

class MainTheme {

  static const Color primaryColor01 = Color(0xFF4A628A);
  static const Color primaryColor02 = Color(0xFF7FC7D9);
  static const Color primaryColor03 = Color(0xFFB9E5E8);
  static const Color primaryColor04 = Color(0xFFDCF2F1);
  static const Color primaryColor05 = Color(0xFFDFF2EB);

  static const Color textContrast01 = Color(0xFF0F1035);

  static const Color inversePrimary = primaryColor01;

  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor01,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor01,
        primary: primaryColor01,
        secondary: primaryColor02,
        onPrimary: textContrast01,
        inversePrimary: primaryColor05,
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