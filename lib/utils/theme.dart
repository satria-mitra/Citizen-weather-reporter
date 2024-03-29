import 'package:flutter/material.dart';
import 'package:weathershare/utils/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()));

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
  );
}
