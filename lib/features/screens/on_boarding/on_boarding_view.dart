import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weathershare/constants/text_string.dart';
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

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: isLastPage
          ? getStarted()
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 30.0), // Raise the buttons up
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Adjust spacing
                  children: [
                    TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text("Skip"),
                    ),
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
                    TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = index == controller.items.length - 1),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
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

  Widget getStarted() {
    return Container(
      color: Colors.lightBlue,
      width: double.infinity,
      height: 60, // Adjust the height if needed
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // Define what happens when you press the "Get Started" button
        },
        child: const Text(
          tGetStarted,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white), // Adjust the text style as needed
        ),
      ),
    );
  }
}
