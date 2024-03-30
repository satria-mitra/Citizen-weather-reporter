import 'package:flutter/material.dart';
import 'package:weathershare/constants/colors.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(150, 50),
      foregroundColor: secondaryColor,
      side: const BorderSide(color: secondaryColor),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(100, 50),
      foregroundColor: whiteColor,
      side: const BorderSide(color: secondaryColor),
    ),
  );
}
