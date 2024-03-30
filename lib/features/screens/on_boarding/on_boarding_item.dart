import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_info.dart';
import 'package:weathershare/constants/text_string.dart';

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
