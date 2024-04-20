import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBrokersController extends GetxController {
  static AddBrokersController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final hidePassword = true.obs;

  final mqttName = TextEditingController();
  final mqttHost = TextEditingController();
  final mqttPort = TextEditingController();
  final mqttUsername = TextEditingController();
  final mqttPassword = TextEditingController();

  GlobalKey<FormState> brokersFormKey = GlobalKey<FormState>();

  // Method to fetch broker names from Firestore
  Future<List<String>> fetchBrokerNames() async {
    try {
      QuerySnapshot snapshot = await _db.collection('brokers').get();
      List<String> brokerNames = snapshot.docs.map((doc) => doc.id).toList();
      if (brokerNames.isEmpty) {
        brokerNames.add('No Brokers Found');
      }
      return brokerNames;
    } catch (e) {
      print("Failed to fetch broker names: $e");
      return ['Fetch Failed'];
    }
  }

  // Saves new broker details to Firestore
  Future<void> saveBrokerDetails() async {
    if (brokersFormKey.currentState?.validate() ?? false) {
      String brokerId = mqttName.text
          .trim()
          .replaceAll(' ', '_'); // Replace spaces with underscores
      try {
        await _db.collection('brokers').doc(brokerId).set({
          'mqttname': mqttName.text.trim(),
          'host': mqttHost.text.trim(),
          'port': mqttPort.text.trim(),
          'username': mqttUsername.text.trim(),
          'password': mqttPassword.text.trim(),
        });
        Get.snackbar('Success', 'Broker saved successfully',
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save broker: $e',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        print("Failed to save broker details: $e");
      }
    }
  }
}
