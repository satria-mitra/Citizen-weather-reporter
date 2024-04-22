import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(150, 50),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF272727),
      side: const BorderSide(color: Color(0xFF272727)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(150, 50),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF272727),
      side: const BorderSide(color: Color(0xFF272727)),
    ),
  );
}
