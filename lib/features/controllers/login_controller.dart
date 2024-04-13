import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weathershare/features/controllers/user_controller.dart';
import 'package:weathershare/repository/auth_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Variables
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //Sign in with email and password
  Future<void> emailAndPasswordSignIn() async {
    final userCredentials = await AuthenticationRepo.instance
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

    await userController.fetchUserRecord();
    await AuthenticationRepo.instance.screenRedirect(userCredentials.user);
  }
}
