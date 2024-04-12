import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_view.dart';
import 'package:weathershare/features/screens/welcome/welcome_screen.dart';
import 'package:weathershare/repository/exceptions/signup_email_password_failure.dart';
import 'package:weathershare/screens/homescreen.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';

class Authentication extends GetxController {
  static Authentication get instance => Get.find();

  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final _logger = Logger(); // Create a Logger instance

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    if (kDebugMode) {
      print("-- get storage --");
      print(deviceStorage.read('IsFirstTime'));
    }
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(const OnBoardingView());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      _logger.e('Firebase Auth Exception - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      _logger.e('Exception - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Assuming you want to navigate to the HomeScreen upon successful login
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      // Handle the FirebaseAuthException e, e.g., by showing an error message
      final errorMessage = e.message ?? "An unknown error occurred.";
      Get.snackbar("Login Error",
          errorMessage); // Example: Displaying an error message using a snackbar
    } catch (_) {
      // Handle any other exceptions
      Get.snackbar("Login Error",
          "An unexpected error occurred."); // Example: Displaying a generic error message
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
