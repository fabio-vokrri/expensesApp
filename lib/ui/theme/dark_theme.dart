import "package:expenses/ui/theme/constants.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

ThemeData getDarkTheme() {
  ThemeData base = ThemeData.dark();

  return base.copyWith(
    useMaterial3: true,
    primaryColor: Colors.blueGrey[400],
    textTheme: GoogleFonts.latoTextTheme(base.textTheme),
    cardColor: darkPrimaryColor,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
  );
}
