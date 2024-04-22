import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IoTDevicesController extends GetxController {
  static IoTDevicesController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final RxString selectedBroker = ''.obs; // Reactive selected broker

  final hidePassword = true.obs;
  final mqttName = TextEditingController();
  final mqttHost = TextEditingController();
  final mqttPort = TextEditingController();
  final mqttUsername = TextEditingController();
  final mqttPassword = TextEditingController();
  final mqttTopic = TextEditingController();
  final deviceName = TextEditingController();
  final deviceId = TextEditingController();
  final deviceLong = TextEditingController();
  final deviceLat = TextEditingController();
  final mqttBrokerName = TextEditingController();

  GlobalKey<FormState> iotDeviceFormKey = GlobalKey<FormState>();

  // Fetch broker names from Firestore
  Future<List<String>> fetchBrokerNames() async {
    try {
      QuerySnapshot snapshot = await _db.collection('brokers').get();
      List<String> brokerNames = snapshot.docs.map((doc) => doc.id).toList();
      if (brokerNames.isEmpty) {
        brokerNames.add('No Brokers Found');
      }
      return brokerNames;
    } catch (e) {
      //("Failed to fetch broker names: $e");
      return ['Fetch Failed'];
    }
  }

  // Saves new broker details to Firestore
  Future<void> saveBrokerDetails() async {
    if (iotDeviceFormKey.currentState?.validate() ?? false) {
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
        selectedBroker.value = brokerId; // Update selected broker
      } catch (e) {
        Get.snackbar('Error', 'Failed to save broker: $e',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        //print("Failed to save broker details: $e");
      }
    }
  }

  // Method to save IoT device details
  Future<void> saveIoTDevicesDetails() async {
    if (iotDeviceFormKey.currentState?.validate() ?? false) {
      try {
        DocumentReference deviceRef =
            _db.collection('devices').doc(deviceId.text);
        await deviceRef.set({
          'topic': mqttTopic.text.trim(),
          'deviceName': deviceName.text.trim(),
          'deviceID': deviceId.text.trim(),
          'location': {
            'latitude': double.tryParse(deviceLat.text) ?? 0.0,
            'longitude': double.tryParse(deviceLong.text) ?? 0.0
          },
          'brokerRef': _db
              .collection('brokers')
              .doc(selectedBroker.value) // Use selected broker
        });
        Get.snackbar('Success', 'Device details added successfully!',
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      } catch (e, stackTrace) {
        //print('Error adding device details: $e');
        //print('Stack trace: $stackTrace');
        Get.snackbar('Error', 'Failed to add device details: $e',
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}

class MqttDevices {
  String brokerMQTT;
  String userMQTT;
  String portMQTT;
  String passMQTT;
  String devicesName;
  String devicesID;
  String devicesLong;
  String devicesLatt;

  MqttDevices({
    required this.brokerMQTT,
    required this.userMQTT,
    required this.portMQTT,
    required this.passMQTT,
    required this.devicesName,
    required this.devicesID,
    required this.devicesLong,
    required this.devicesLatt,
  });

  static MqttDevices empty() => MqttDevices(
        brokerMQTT: '',
        userMQTT: '',
        portMQTT: '',
        passMQTT: '',
        devicesName: '',
        devicesID: '',
        devicesLong: '',
        devicesLatt: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'BrokerMQTT': brokerMQTT,
      'UserMQTT': userMQTT,
      'PassMQTT': passMQTT,
      'PortMQTT': portMQTT,
      'DevicesName': devicesName,
      'DevicesID': devicesID,
      'DevicesLong': devicesLong,
      'DevicesLatt': devicesLatt,
    };
  }

  factory MqttDevices.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data() ?? {};
    return MqttDevices(
      brokerMQTT: data['BrokerMQTT'] ?? '',
      userMQTT: data['UserMQTT'] ?? '',
      portMQTT: data['PortMQTT'] ?? '',
      passMQTT: data['PassMQTT'] ?? '',
      devicesName: data['DevicesName'] ?? '',
      devicesID: data['DevicesID'] ?? '',
      devicesLong: data['DevicesLong'] ?? '',
      devicesLatt: data['DevicesLatt'] ?? '',
    );
  }
}
