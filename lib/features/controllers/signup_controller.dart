import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/repository/auth_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  void registerUser(String email, String password) {
    Authentication.instance.createUserWithEmailAndPassword(email, password);
  }
}
