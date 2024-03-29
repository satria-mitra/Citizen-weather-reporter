import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensure the Stack fills the whole screen
        children: [
          Image.asset(tOnBoardingImages1, fit: BoxFit.cover),
          const Positioned(
            bottom: 80, // Adjust if necessary to ensure visibility
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tAppName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24, // Example size, adjust as needed
                    color: Colors
                        .white, // Example color for contrast, adjust as needed
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 3.0,
                        color: Color.fromARGB(150, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  tAppTagLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, // Example size, adjust as needed
                    color: Colors
                        .white, // Example color for contrast, adjust as needed
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 2),
                        blurRadius: 3.0,
                        color: Color.fromARGB(150, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
