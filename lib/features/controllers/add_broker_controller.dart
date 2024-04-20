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
      List<String> brokerNames = snapshot.docs
          .map((doc) => doc.data().containsKey('name')
              ? doc.data()['name'] as String
              : 'Unnamed Broker') // Checks if 'name' exists and is not null
          .toList();
      if (brokerNames.isEmpty) {
        // Ensures there's always a non-null return
        return [
          'No Brokers Found'
        ]; // You might want to handle this case differently in your UI
      }
      return brokerNames;
    } catch (e) {
      print("Failed to fetch broker names: $e");
      return ['Fetch Failed']; // Provides a default value in case of failure
    }
  }

  // Other methods...
}
