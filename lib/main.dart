import 'package:flutter/material.dart';
import 'package:weatherly/splash/onboard.dart';
import 'package:weatherly/splash/splash_screen.dart';
import 'package:weatherly/screens/homescreen.dart';
import 'package:weatherly/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const OnBoard(),
    );
  }
}
