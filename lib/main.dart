import 'package:flutter/material.dart';
// import 'package:weathershare/splash/onboard.dart';
// import 'package:weathershare/splash/splash_screen.dart';
//import 'package:weathershare/screens/homescreen.dart';
import 'package:weathershare/utils/theme.dart';

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
        home: SplashScreen());
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("weathershare/"),
      ),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
