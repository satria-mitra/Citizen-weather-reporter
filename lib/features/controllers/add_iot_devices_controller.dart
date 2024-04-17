import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IoTDevicesController extends GetxController {
  static IoTDevicesController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final hidePassword = true.obs;
  final mqttHost = TextEditingController();
  final mqttPort = TextEditingController();
  final mqttUsername = TextEditingController();
  final mqttPassword = TextEditingController();
  final mqttTopic = TextEditingController();
  final deviceName = TextEditingController();
  final deviceLong = TextEditingController();
  final deviceLat = TextEditingController();
  GlobalKey<FormState> iotDeviceFormKey = GlobalKey<FormState>();

  Future<void> addBrokerDetails(
      String host,
      String port,
      String username,
      String password,
      String parameter,
      String topic,
      String deviceName,
      double latitude,
      double longitude) async {
    try {
      await _db.collection('mqttBrokers').add({
        'host': host,
        'port': port,
        'username': username,
        'password': password,
        'parameter': parameter,
        'topic': topic,
        'deviceName': deviceName,
        'location': {'latitude': latitude, 'longitude': longitude},
        'createdAt': FieldValue.serverTimestamp(), // Adds server-side timestamp
      });
      Get.snackbar('Success', 'Broker details added successfully!',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add broker details: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      print(e.toString());
    }
  }
}
