import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weathershare/features/screens/login/login_screen.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_view.dart';
import 'package:weathershare/features/screens/welcome/welcome_screen.dart';
import 'package:weathershare/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weathershare/utils/storage/storage.dart';
//import 'package:weathershare/utils/storage/storage.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;

  /// Getters
  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  String get getUserEmail => _firebaseUser.value?.email ?? "";

  String get getDisplayName => _firebaseUser.value?.displayName ?? "";

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    deviceStorage.writeIfNull('IsFirstTime', true);
    var isFirstTime = deviceStorage.read('IsFirstTime');
    // print(
    //     'is it first time ? $isFirstTime'); // Optional: for debugging purposes

    if (deviceStorage.read('isFirstTime') != true) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const OnBoardingView());
    }
    screenRedirect(_firebaseUser.value);
  }

  screenRedirect(User? user) async {
    if (user != null) {
      // User is logged in
      await LocalStorage.init(user.uid);
      Get.offAll(() => const HomeMenu());
    } else {
      Get.offAll(() => const WelcomeScreen());
    }

    // User is not logged in or doesn't exist
    // deviceStorage.writeIfNull('IsFirstTime', true);
    // var isFirstTime = deviceStorage.read('IsFirstTime');
    // print(isFirstTime); // Optional: for debugging purposes

    // Check if it's not the first time and redirect accordingly
    //   deviceStorage.read('isFirstTime') != true
    //       ? Get.offAll(() => const LoginScreen())
    //       : Get.offAll(() => const OnBoardingView());
    // }
  }

  //Sign up
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Assuming you want to navigate to the HomeScreen upon successful login
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

//Sign in with google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //forget password
  Future<void> sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw 'Something wrong with Authentication. Please try again';
    } on FirebaseException catch (e) {
      throw 'An unknown Firebase error occurred. Please try again';
    } on FormatException catch (_) {
      throw 'The email address format is invalid. Please enter a valid email.';
    } on PlatformException catch (e) {
      throw 'An unexpected platform error occurred. Please try again.';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
