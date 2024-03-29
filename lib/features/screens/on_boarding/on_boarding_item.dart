import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_info.dart';
import 'package:weathershare/constants/text_string.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: tOnBoardingTitle1,
        description: tOnBoardingSubTitle1,
        image: tOnBoardingImages1),
    OnboardingInfo(
        title: tOnBoardingTitle2,
        description: tOnBoardingSubTitle2,
        image: tOnBoardingImages2),
    OnboardingInfo(
        title: tOnBoardingTitle3,
        description: tOnBoardingSubTitle3,
        image: tOnBoardingImages3),
  ];
}
