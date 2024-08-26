import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // font example: https://fonts.google.com

const Color primary1 = Color.fromARGB(255, 15, 15, 15);
const Color primary2 = Color.fromARGB(255, 30, 30, 30);
const Color primary3 = Color.fromARGB(255, 45, 45, 45);
const Color secondary = Color.fromARGB(255, 140, 200, 255);

TextStyle textStyle(double fontSize, bool isTitle) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
    fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: primary2,
    primaryColor: primary3,
    secondaryHeaderColor: secondary,
    iconTheme: IconThemeData(color: Colors.white, size: 16),
    textTheme: TextTheme(
      titleLarge: textStyle(32, true),
      titleMedium: textStyle(28, true),
      titleSmall: textStyle(24, true),
      bodyLarge: textStyle(20, false),
      bodyMedium: textStyle(16, false),
      bodySmall: textStyle(12, false),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary3,
      iconTheme: IconThemeData(color: secondary, size: 24),
      titleTextStyle: textStyle(16, true).copyWith(color: secondary),
      toolbarTextStyle: textStyle(16, true).copyWith(color: secondary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary1,
      selectedItemColor: secondary,
      unselectedItemColor: Colors.white.withOpacity(0.2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(textStyle(20, true)),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondary,
      refreshBackgroundColor: primary3,
      circularTrackColor: primary3,
    ),
  );
}
