import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        labelLarge: GoogleFonts.montserrat(
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: Colors.black54,
          fontSize: 24,
        ),
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
          labelLarge: GoogleFonts.montserrat(
            color: Colors.white70,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.white60,
            fontSize: 24,
          )));
}
