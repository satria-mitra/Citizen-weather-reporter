import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/models/user_model.dart';
import 'package:weathershare/home_screen.dart';
import 'package:weathershare/repository/auth_repo.dart';
import 'package:weathershare/features/controllers/user_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    await AuthenticationRepo.instance.createUserWithEmailAndPassword(
        email.text.trim(), password.text.trim());

    final newUser = UserModel(
      id: AuthenticationRepo.instance.getUserID,
      firstname: firstName.text.trim(),
      lastname: lastName.text.trim(),
      email: email.text.trim(),
      profilePicture: '',
    );

    await UserController.instance.saveUserRecord(user: newUser);
    Get.to(() => const HomeMenu());
  }

  void registerUser(String email, String password) {
    AuthenticationRepo.instance.createUserWithEmailAndPassword(email, password);
  }
}
