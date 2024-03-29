import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_item.dart';
//import 'package:weathershare/utils/text_theme.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        children: [
          //skip button
          TextButton(onPressed: () {}, child: const Text("Skip")),

          //next button
          TextButton(onPressed: () {}, child: const Text("Next")),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(
                    height: 15), // This needed to be moved inside the list
                Text(controller.items[index].title,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].description,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
