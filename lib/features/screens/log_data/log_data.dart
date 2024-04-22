import 'package:flutter/material.dart';
import 'package:weathershare/constants/colors.dart'; // Make sure these constants are correctly defined
import 'package:weathershare/constants/sizes.dart'; // Make sure these constants are correctly defined
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weathershare/features/models/data_model.dart';

class LogDataScreen extends StatefulWidget {
  const LogDataScreen({super.key});

  @override
  State<LogDataScreen> createState() => _LogDataScreenState();
}

class DeviceDataSource extends DataTableSource {
  final List<DeviceData> data;
  BuildContext context;

  DeviceDataSource(this.data, this.context);

  @override
  DataRow getRow(int index) {
    final device = data[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(device.time)), // Example field
        DataCell(Text('${device.tempAvg}')), // Example field
        DataCell(Text('${device.rhAvg}')), // Example field
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
            // Check if dataSource is initialized
            dataSource == null
                ? CircularProgressIndicator()
                : PaginatedDataTable(
                    header: Text('Device Data'),
                    columns: [
                      DataColumn(label: Text('Time')),
                      DataColumn(label: Text('Temp Avg')),
                      DataColumn(label: Text('RH Avg')),
                    ],
                    source: dataSource,
                  ),
          ],
        ),
      ),
    );
  }
}
