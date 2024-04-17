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

  Future<void> addBrokerDetails() async {
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
    } catch (e) {
      Get.snackbar('Error', 'Failed to add broker details: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      print(e.toString());
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

  //function to create empty user model
  static MqttDevices empty() => MqttDevices(
      brokerMQTT: '',
      userMQTT: '',
      portMQTT: '',
      passMQTT: '',
      devicesName: '',
      devicesID: '',
      devicesLong: '',
      devicesLatt: '');

  //convert model to json structure
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

  //method to create a UserModel from a Firebase document snapshot.
  factory MqttDevices.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    var data = doc.data() ?? {};
    return MqttDevices(
      devicesID: data['DevicesID'] ?? '',
      brokerMQTT: data['BrokerMQTT'] ?? '',
      userMQTT: data['UserMQTT'] ?? '',
      passMQTT: data['PassMQTT'] ?? '',
      portMQTT: data['PortMQTT'] ?? '',
      devicesName: data['DevicesName'] ?? '',
      devicesLong: data['DevicesLong'] ?? '',
      devicesLatt: data['DevicesLatt'] ?? '',
    );
  }
}
