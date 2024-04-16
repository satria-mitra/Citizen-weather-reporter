import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/models/user_model.dart';
import 'package:weathershare/repository/auth_repo.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  //Function to save user data to firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
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

  //function to fetch user details based on user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("users")
          .doc(AuthenticationRepo.instance.getUserID)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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
