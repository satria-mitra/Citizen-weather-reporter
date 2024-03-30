import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image(image: AssetImage(welcomeScreenImage)),
            Text(welcomeTitle),
            Text(welcomeSubTitle),
            Row(
              children: [
                OutlinedButton(onPressed: () {}, child: const Text(login)),
                ElevatedButton(onPressed: () {}, child: const Text(signUp))
              ],
            )
          ],
        ),
      ),
    );
  }
}
