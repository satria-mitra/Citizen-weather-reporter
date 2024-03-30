import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Container(
        child: Column(
          Image(image: AssetImage(welcomeScreenImage)),
          Text(welcomeTitle),
          Text(welcomeSubTitle),
        )
      ),
      ),
    );
  }
}
