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

  final deviceName = TextEditingController();
  final deviceTopic = TextEditingController();
  final deviceID = TextEditingController();
  final deviceLong = TextEditingController();
  final deviceLat = TextEditingController();

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

  // Method to fetch devices names from Firestore
  Future<List<String>> fetchDeviceNames() async {
    try {
      QuerySnapshot snapshot = await _db.collection('devices').get();
      List<String> deviceNames = snapshot.docs.map((doc) => doc.id).toList();
      if (deviceNames.isEmpty) {
        deviceNames.add('No Devices Found');
      }
      return deviceNames;
    } catch (e) {
      print("Failed to fetch device names: $e");
      return ['Fetch Failed'];
    }
  }

  // Clear all text fields
  void clearBrokerFields() {
    mqttName.clear();
    mqttHost.clear();
    mqttPort.clear();
    mqttUsername.clear();
    mqttPassword.clear();
  }

  void clearDeviceFields() {
    deviceName.clear();
    deviceTopic.clear();
    deviceID.clear();
    deviceLong.clear();
    deviceLat.clear();
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

  // Load device details into the text fields for editing
  Future<void> loadDeviceDetails(String deviceId) async {
    DocumentSnapshot brokerDoc =
        await _db.collection('devices').doc(deviceId).get();
    if (brokerDoc.exists) {
      Map<String, dynamic>? data = brokerDoc.data() as Map<String, dynamic>?;
      if (data != null) {
        deviceName.text = data['deviceName'] ?? '';
        deviceTopic.text = data['topic'] ?? '';
        deviceID.text = data['deviceID'] ?? '';
        deviceLong.text = data['long'] ?? '';
        deviceLat.text = data['latt'] ?? '';
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

  // Saves new device details to Firestore
  Future<void> saveDeviceDetails() async {
    if (brokersFormKey.currentState?.validate() ?? false) {
      var existingDevices = await _db
          .collection('devices')
          .where('deviceName', isEqualTo: deviceName.text.trim())
          .where('deviceID', isEqualTo: deviceID.text.trim())
          .where('topic', isEqualTo: deviceTopic.text.trim())
          .get();

      if (existingDevices.docs.isNotEmpty) {
        // Broker already exists
        Get.snackbar(
            'Device Exists', 'A Device with similar details already exists.',
            backgroundColor: Colors.amber, snackPosition: SnackPosition.BOTTOM);
        return; // Stop execution if broker exists
      }
      DocumentReference brokerRef = _db
          .collection('brokers')
          .doc(mqttName.text.trim().replaceAll(' ', '_'));

      try {
        await _db.collection('devices').doc(deviceID.text).set({
          'deviceName': deviceName.text.trim(),
          'deviceID': deviceID.text.trim(),
          'topic': deviceTopic.text.trim(),
          'latt': deviceLat.text.trim(),
          'long': deviceLong.text.trim(),
          'brokerRef': brokerRef // Storing the reference to the broker
        });
        Get.snackbar('Success', 'Device saved successfully',
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save Device: $e',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        print("Failed to save broker details: $e");
      }
    }
  }
}
