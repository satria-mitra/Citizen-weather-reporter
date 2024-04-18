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
  final deviceId = TextEditingController();
  final deviceLong = TextEditingController();
  final deviceLat = TextEditingController();
  GlobalKey<FormState> iotDeviceFormKey = GlobalKey<FormState>();

  Future<void> createNewBrokerDetails() async {
    QuerySnapshot existingBroker = await _db
        .collection('mqttBrokers')
        .where('deviceID', isEqualTo: deviceId.text)
        .get();

    if (existingBroker.docs.isNotEmpty) {
      // If there is an existing broker with the same deviceID, show a snackbar and return
      Get.snackbar(
          'Broker Already Added', 'This broker has already been added.',
          backgroundColor: Colors.amber, snackPosition: SnackPosition.BOTTOM);
      return; // Stop the function here if broker already exists
    }
    try {
      await _db.collection('mqttBrokers').add({
        'host': mqttHost.text,
        'port': mqttPort.text,
        'username': mqttUsername.text,
        'password': mqttPassword.text,
        'topic': mqttTopic.text,
        'deviceName': deviceName.text,
        'deviceID': deviceId.text,
        'location': {
          'latitude': double.tryParse(deviceLat.text) ?? 0.0,
          'longitude': double.tryParse(deviceLong.text) ?? 0.0
        },
      });
      Get.snackbar('Success', 'Broker details added successfully!',
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    } catch (e, stackTrace) {
      print('Error adding broker details: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', 'Failed to add broker details: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
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
