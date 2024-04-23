import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/screens/welcome/welcome_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weathershare/constants/image_strings.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class OnboardingInfo {
  final String title;
  final String description;
  final String image;

  OnboardingInfo(
      {required this.title, required this.description, required this.image});
}

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: onBoardingTitle1,
        description: onBoardingSubTitle1,
        image: onBoardingImages1),
    OnboardingInfo(
        title: onBoardingTitle2,
        description: onBoardingSubTitle2,
        image: onBoardingImages2),
    OnboardingInfo(
        title: onBoardingTitle3,
        description: onBoardingSubTitle3,
        image: onBoardingImages3),
  ];
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 10),
              child: isLastPage
                  ? getStarted()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Skip button
                        TextButton(
                            onPressed: () => pageController
                                .jumpToPage(controller.items.length - 1),
                            child: const Text("Skip")),

                        // indicator
                        SmoothPageIndicator(
                          controller: pageController,
                          count: controller.items.length,
                          onDotClicked: (index) => pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn),
                          effect: const WormEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              activeDotColor: Colors.grey),
                        ),

                        // Next button
                        TextButton(
                            onPressed: () => pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                            child: const Text("Next")),
                      ],
                    ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = index == controller.items.length - 1),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
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
        ));
  }

  Widget getStarted() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: 60,
      child: ElevatedButton(
        onPressed: () async {
          final storage = GetStorage();

          if (kDebugMode) {
            //print("--- get storage ---");
          }
          storage.write('IsFirstTime', false);
          //print(storage.read('IsFirstTime'));

          //print("Setting onboarding to true"); // Debug line

          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        },
        child: const Text(
          getStart,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
