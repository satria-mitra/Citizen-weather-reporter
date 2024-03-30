import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weathershare/constants/text_string.dart';
//import 'package:flutter/widgets.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_item.dart';
//import 'package:weathershare/utils/text_theme.dart';
//import 'package:weathershare/utils/theme.dart';

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
        bottomSheet: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 90.0, horizontal: 10),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Theme.of(context).primaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 60,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          getStart,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
