import "package:expenses/ui/theme/constants.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData getDarkTheme() {
  ThemeData base = ThemeData.dark();

  return base.copyWith(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimaryColor,
      error: darkErrorColorBackground,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          color: Colors.white,
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
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
  );
}
