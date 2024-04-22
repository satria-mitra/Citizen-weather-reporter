import 'package:flutter/material.dart';
import 'package:weathershare/constants/colors.dart'; // Make sure these constants are correctly defined
import 'package:weathershare/constants/sizes.dart'; // Make sure these constants are correctly defined
import 'package:cloud_firestore/cloud_firestore.dart';

class LogDataScreen extends StatefulWidget {
  const LogDataScreen({super.key});

  @override
  State<LogDataScreen> createState() => _LogDataScreenState();
}

class _LogDataScreenState extends State<LogDataScreen> {
  String? selectedDevice;
  List<String> devices = [];

  @override
  void initState() {
    super.initState();
    fetchDeviceNames();
  }

  Future<void> fetchDeviceNames() async {
    FirebaseFirestore.instance.collection('devices').get().then((snapshot) {
      List<String> fetchedDevices = [];
      for (var doc in snapshot.docs) {
        var deviceName = doc.data()['deviceName']
            as String; // Assuming 'deviceName' is the field
        if (deviceName != null) {
          fetchedDevices.add(deviceName);
        }
      }
      setState(() {
        devices = fetchedDevices;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        title: Text("Data Log"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(defaultSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDevice,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDevice = newValue;
                      });
                    },
                    items:
                        devices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text('Select a Device'),
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),
          if (selectedDevice != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('You selected: $selectedDevice'),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Please select a device.'),
            )
        ],
      ),
    );
  }
}
