import "package:expenses/ui/theme/constants.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData getDarkTheme() {
  ThemeData base = ThemeData.dark();

  return base.copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(primary: darkPrimaryColor),
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    cardColor: darkPrimaryColor,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
  );
}
