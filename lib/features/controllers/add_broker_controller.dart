import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBrokersController extends GetxController {
  static AddBrokersController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final mqttHost = TextEditingController();
  final mqttPort = TextEditingController();
  final mqttUsername = TextEditingController();
  final mqttPassword = TextEditingController();

  GlobalKey<FormState> brokersFormKey = GlobalKey<FormState>();

  // Existing methods...

  // Method to fetch broker names from Firestore
  Future<List<String>> fetchBrokerNames() async {
    try {
      QuerySnapshot snapshot = await _db.collection('mqttBrokers').get();
      List<String> brokerNames = snapshot.docs.map((doc) {
        var data =
            doc.data() as Map<String, dynamic>?; // Cast to a nullable Map
        if (data != null && data.containsKey('name')) {
          return data['name'] as String; // Safely return the name if available
        } else {
          return 'Unnamed Broker'; // Default name if 'name' key is missing or data is null
        }
      }).toList();
      if (brokerNames.isEmpty) {
        return [
          'No Brokers Found'
        ]; // Return this if no brokers are available at all
      }
      return brokerNames; // Return the list of names
    } catch (e) {
      print("Failed to fetch broker names: $e");
      return ['Fetch Failed']; // Return this in case of any exceptions
    }
  }

  // Saves new broker details to Firestore
  Future<void> saveBrokerDetails() async {
    if (brokersFormKey.currentState?.validate() ?? false) {
      // Ensures form is valid
      try {
        await _db.collection('brokers').add({
          'host': mqttHost.text
              .trim(), // Using trim to remove any leading/trailing whitespace
          'port': mqttPort.text.trim(),
          'username': mqttUsername.text.trim(),
          'password': mqttPassword.text.trim(),
        });
        Get.snackbar('Success', 'Broker saved successfully!',
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save broker: $e',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        print("Failed to save broker details: $e");
      }
    }
  }
}
