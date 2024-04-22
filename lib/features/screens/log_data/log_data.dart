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
  DateTime? selectedDate; // To store the selected date

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024, 4, 21),
      lastDate: DateTime(2024, 4, 23),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
                SizedBox(
                    width:
                        20), // Spacing between the dropdown and the date picker
                OutlinedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(selectedDate == null
                      ? 'Pick a Date'
                      : '${selectedDate!.toIso8601String().substring(0, 10)}'),
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
              child: Text('Please select a device.'),
            ),
          if (selectedDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Selected Date: ${selectedDate!.toIso8601String().substring(0, 10)}'),
            ),
        ],
      ),
    );
  }
}
