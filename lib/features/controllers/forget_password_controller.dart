import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/repository/auth_repo.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      await AuthenticationRepo.instance
          .sendPasswordResetEmail(email.text.trim());
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {}
  }

  resendPasswordResetEmail(String email) async {
    try {} catch (e) {}
  }
}
