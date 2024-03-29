import 'package:flutter/material.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LiquidSwipe(
        pages: [
          OnBoardingPage(size: size),
          // Add more pages as needed
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
          tDefaultSize), // Removed const here if tDefaultSize is not a compile-time constant
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(tOnBoardingImages1),
            height: size.height * 0.5,
          ),
          Column(
            children: [
              Text(
                tOnBoardingTitle1,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                tOnBoardingSubTitle1,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          Text(
            tOnBoardingCounter1,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
