import 'package:flutter/material.dart';
import 'package:weathershare/constants/colors.dart'; // Make sure these constants are correctly defined
import 'package:weathershare/constants/sizes.dart'; // Make sure these constants are correctly defined
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weathershare/features/models/data_model.dart';
import 'package:firebase_database/firebase_database.dart' as rtdb;

class LogDataScreen extends StatefulWidget {
  const LogDataScreen({super.key});

  @override
  State<LogDataScreen> createState() => _LogDataScreenState();
}

class DeviceDataSource extends DataTableSource {
  final List<DeviceData> data;
  BuildContext context;
  bool sortAscending = true;

  DeviceDataSource(this.data, this.context);

  @override
  DataRow getRow(int index) {
    final device = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(device.time)),
        DataCell(Text(device.tempAvg)),
        DataCell(Text(device.rhAvg)),
      ],
    );
  }

  @override
  int get rowCount => data.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}

class _LogDataScreenState extends State<LogDataScreen> {
  String? selectedDevice;
  List<String> devices = [];
  DateTime? selectedDate; // To store the selected date
  DateTime? selectedTime; // To store the selected date
  List<DeviceData> tableData = []; // Your data list
  late DeviceDataSource dataSource;

  @override
  void initState() {
    super.initState();
    dataSource = DeviceDataSource([], context); // Initialize with empty data
    fetchDeviceNames();
  }

  void updateData(List<DeviceData> newData) {
    setState(() {
      tableData = newData;
      dataSource = DeviceDataSource(tableData, context);
    });
  }

  Future<void> fetchDeviceNames() async {
    FirebaseFirestore.instance.collection('devices').get().then((snapshot) {
      List<String> fetchedDevices = [];
      for (var doc in snapshot.docs) {
        var deviceName = doc.data()['deviceName']
            as String; // Assuming 'deviceName' is the field
        var deviceID = doc.data()['deviceID']
            as String; // Assuming 'deviceName' is the field
        if (deviceName != null) {
          fetchedDevices.add(deviceID);
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

  Future<void> fetchData() async {
    if (selectedDevice == null || selectedDate == null) {
      print("Please select both a device and a date.");
      return;
    }

    // Convert selectedDate to the required format (yyyy-mm-dd)
    String formattedDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    // Fetch data from Firebase using the selected device ID and formatted date
    String deviceId = devices.firstWhere((name) => name == selectedDevice,
        orElse: () => "No Device Found" // Providing a default non-null String
        );
    if (deviceId == null) {
      print("Selected device ID not found in the list.");
      return;
    }
    print('Querying RTDB at: devices/$deviceId/$formattedDate');
    var ref =
        rtdb.FirebaseDatabase.instance.ref('devices/$deviceId/$formattedDate');

    var snapshot = await ref.once();
    print('Data fetched: ${snapshot.snapshot.value}');

    var data = snapshot.snapshot.value;

    if (data != null) {
      List<DeviceData> newData = [];
      (data as Map).forEach((key, value) {
        // Assuming value is a Map with ta_avg and rh_avg keys
        var timeData = Map<String, dynamic>.from(value);
        newData.add(DeviceData(
            time: key, // hh-mm-ss
            tempAvg: timeData['temp_avg'].toString(),
            rhAvg: timeData['rh_avg'].toString()));
      });
      updateData(newData);
    } else {
      print("No data available for this device on the selected date.");
      updateData([]); // Update with empty data if no data is found
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
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
                SizedBox(width: 20), // Spacing
                OutlinedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(selectedDate == null
                      ? 'Pick a Date'
                      : '${selectedDate!.toIso8601String().substring(0, 10)}'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Load Data'),
            ),
            // Check if dataSource is initialized
            PaginatedDataTable(
              columns: [
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Temp Avg')),
                DataColumn(label: Text('RH Avg')),
              ],
              source: dataSource,
              // other properties as needed
            ),
          ],
        ),
      ),
    );
  }
}
