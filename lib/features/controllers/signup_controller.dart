import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/models/user_model.dart';
import 'package:weathershare/repository/auth_repo.dart';
import 'package:weathershare/features/controllers/user_controller.dart';
//import 'package:weathershare/features/models/user_model.dart';
//import 'package:weathershare/repository/auth_repo.dart';
import 'package:weathershare/repository/authentication.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    await Authentication.instance.createUserWithEmailAndPassword(
        email.text.trim(), password.text.trim());

    final newUser = UserModel(
      id: AuthenticationRepo.instance.getUserID,
      firstname: firstName.text.trim(),
      lastname: lastName.text.trim(),
      email: email.text.trim(),
      profilePicture: '',
    );

    await UserController.instance.saveUserRecord(user: newUser);
    //Get.to(() => const VerifyEmailScreen());
  }

  void registerUser(String email, String password) {
    Authentication.instance.createUserWithEmailAndPassword(email, password);
  }
}
