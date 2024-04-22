import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(150, 50),
      foregroundColor: const Color(0xFF272727),
      side: const BorderSide(color: Color(0xFF272727)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(150, 50),
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white),
    ),
  );
}
