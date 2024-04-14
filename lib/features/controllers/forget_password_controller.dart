import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/screens/forget_password/reset_password.dart';
import 'package:weathershare/repository/auth_repo.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    // Send EMail to Reset Password
    await AuthenticationRepo.instance.sendPasswordResetEmail(email.text.trim());
    Get.to(() => ResetPasswordScreen(email: email.text.trim()));
  }

  resendPasswordResetEmail(String email) async {
    await AuthenticationRepo.instance.sendPasswordResetEmail(email.trim());
  }
}
