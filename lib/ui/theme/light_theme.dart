import "package:expenses/ui/theme/constants.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData getLightTheme() {
  final ThemeData base = ThemeData();

  return base.copyWith(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: lightPrimaryColor,
      error: lightErrorColorBackground,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          color: Colors.black,
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      errorStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );
}
