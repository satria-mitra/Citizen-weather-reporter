import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 16,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 16,
    ),
  );
}
