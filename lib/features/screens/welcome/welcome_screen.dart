import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: const AssetImage(welcomeScreenImage),
                height: height * 0.6),
            Column(
              children: [
                Text(
                  welcomeTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  welcomeSubTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {}, 
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: 
                      ),
                      child: Text(login.toUpperCase())),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Text(signUp.toUpperCase())),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
