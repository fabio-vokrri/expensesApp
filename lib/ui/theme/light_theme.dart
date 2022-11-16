import "package:expenses/ui/theme/constants.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData getLightTheme() {
  final ThemeData base = ThemeData();

  return base.copyWith(
    useMaterial3: true,
    textTheme: GoogleFonts.latoTextTheme(),
    cardColor: lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );
}
