

import 'package:get/get.dart';

class FadeInAnimationController extends GetXController(
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration( milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    animate.value = false;
    Get.ofAll() => const WelcomeS
  }
)