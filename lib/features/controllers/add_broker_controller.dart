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

  // Clear all text fields
  void clearFields() {
    mqttName.clear();
    mqttHost.clear();
    mqttPort.clear();
    mqttUsername.clear();
    mqttPassword.clear();
  }

  // Load broker details into the text fields for editing
  Future<void> loadBrokerDetails(String brokerId) async {
    DocumentSnapshot brokerDoc =
        await _db.collection('brokers').doc(brokerId).get();
    if (brokerDoc.exists) {
      Map<String, dynamic>? data = brokerDoc.data() as Map<String, dynamic>?;
      if (data != null) {
        mqttName.text = data['mqttname'] ?? '';
        mqttHost.text = data['host'] ?? '';
        mqttPort.text = data['port'] ?? '';
        mqttUsername.text = data['username'] ?? '';
        mqttPassword.text = data['password'] ?? '';
      }
    }
  }

  // Saves new broker details to Firestore
  Future<void> saveBrokerDetails() async {
    if (brokersFormKey.currentState?.validate() ?? false) {
      var existingBrokers = await _db
          .collection('brokers')
          .where('name', isEqualTo: mqttName.text.trim())
          .where('host', isEqualTo: mqttHost.text.trim())
          .where('port', isEqualTo: mqttPort.text.trim())
          .get();

      if (existingBrokers.docs.isNotEmpty) {
        // Broker already exists
        Get.snackbar(
            'Broker Exists', 'A broker with similar details already exists.',
            backgroundColor: Colors.amber, snackPosition: SnackPosition.BOTTOM);
        return; // Stop execution if broker exists
      }

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
