import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color primaryLightColor = Color(0xFF62b9fb);
  static const Color primaryVariantLightColor = Color(0xFF62b9fb);
  static const Color secondaryLightColor = Color(0xFF03DAC6);
  static const Color backgroundLightColor = Color(0xFFFAFAFA);
  static const Color surfaceLightColor = Color(0xFFFFFFFF);
  static const Color errorLightColor = Color(0xFFB00020);

  // Dark Theme Colors
  static const Color primaryDarkColor = Color(0xFF62b9fb);
  static const Color primaryVariantDarkColor = Color(0xFF0D47A1);
  static const Color secondaryDarkColor = Color(0xFF03DAC6);
  static const Color backgroundDarkColor = Color(0xFF121212);
  static const Color surfaceDarkColor = Color(0xFF1E1E1E);
  static const Color errorDarkColor = Color(0xFFCF6679);

  // Text Colors
  static const Color onPrimaryLightColor = Colors.white;
  static const Color onSecondaryLightColor = Colors.black;
  static const Color onBackgroundLightColor = Colors.black87;
  static const Color onSurfaceLightColor = Colors.black87;
  static const Color onErrorLightColor = Colors.white;

  static const Color onPrimaryDarkColor = Colors.black;
  static const Color onSecondaryDarkColor = Colors.black;
  static const Color onBackgroundDarkColor = Colors.white;
  static const Color onSurfaceDarkColor = Colors.white;
  static const Color onErrorDarkColor = Colors.black;

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryLightColor,
        secondary: secondaryLightColor,
        surface: surfaceLightColor,
        error: errorLightColor,
        onPrimary: onPrimaryLightColor,
        onSecondary: onSecondaryLightColor,
        onSurface: onSurfaceLightColor,
        onError: onErrorLightColor,
      ),
      scaffoldBackgroundColor: backgroundLightColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryLightColor,
        foregroundColor: onPrimaryLightColor,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: onPrimaryLightColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLightColor),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDarkColor,
        secondary: secondaryDarkColor,
        surface: surfaceDarkColor,
        error: errorDarkColor,
        onPrimary: onPrimaryDarkColor,
        onSecondary: onSecondaryDarkColor,
        onSurface: onSurfaceDarkColor,
        onError: onErrorDarkColor,
      ),
      scaffoldBackgroundColor: backgroundDarkColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDarkColor,
        foregroundColor: onSurfaceDarkColor,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        color: surfaceDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkColor,
          foregroundColor: onPrimaryDarkColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryDarkColor),
        ),
      ),
    );
  }
}
