import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weathershare/constants/colors.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              welcomeScreenImage,
              height: height * 0.5,
            ),
            const SizedBox(height: 10),
            Text(
              loginTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              loginSubTitle,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      foregroundColor: whiteColor,
                      backgroundColor: secondaryColor,
                      side: const BorderSide(color: secondaryColor),
                    ),
                    child: Text(login.toUpperCase()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      foregroundColor: secondaryColor,
                      side: const BorderSide(color: secondaryColor),
                    ),
                    child: Text(signUp.toUpperCase()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
