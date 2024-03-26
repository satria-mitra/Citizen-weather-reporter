import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF7FEFF),
  100: Color(0xFFEBFDFF),
  200: Color(0xFFDEFBFF),
  300: Color(0xFFD1F9FF),
  400: Color(0xFFC7F8FF),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFB7F6FF),
  700: Color(0xFFAEF5FF),
  800: Color(0xFFA6F3FF),
  900: Color(0xFF98F1FF),
});
const int _primaryPrimaryValue = 0xFFBDF7FF;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _primaryAccentValue = 0xFFFFFFFF;
