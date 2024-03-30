import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/text_string.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Ensure the Stack fills the whole screen
        children: [
          Image.asset(onBoardingImages1, fit: BoxFit.cover),
          const Positioned(
            bottom: 80, // Adjust if necessary to ensure visibility
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appName,
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
                  appTagLine,
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
