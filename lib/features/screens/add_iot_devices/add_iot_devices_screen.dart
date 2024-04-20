import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/add_broker_controller.dart';
import 'package:weathershare/features/controllers/add_iot_devices_controller.dart';

class AddIoTDevicesScreen extends StatefulWidget {
  final String initialBroker;
  const AddIoTDevicesScreen({super.key, required this.initialBroker});

  @override
  State<AddIoTDevicesScreen> createState() => _AddIoTDevicesScreenState();
}

class _AddIoTDevicesScreenState extends State<AddIoTDevicesScreen> {
  late String selectedBroker;
  List<String> brokers = [];

  @override
  void initState() {
    super.initState();
    selectedBroker =
        widget.initialBroker; // Set initial broker from widget parameter
    brokers = [selectedBroker]; // Start with the initial broker
    loadAdditionalBrokers(); // Then load additional brokers
  }

  void loadAdditionalBrokers() async {
    final controller = Get.put(IoTDevicesController());

    var fetchedBrokers = await controller.fetchBrokerNames();
    print("Fetched brokers: $fetchedBrokers"); // Debug output

    setState(() {
      brokers.addAll(fetchedBrokers
          .where((br) => br != widget.initialBroker && br != "Unnamed Broker")
          .toList());
      print("Brokers for dropdown: $brokers"); // Check final list
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IoTDevicesController());

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        title: Text(
          "Add IoT Device",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          key: controller.iotDeviceFormKey,
          children: [
            Text(
              "Add Devices Metadata",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedBroker,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBroker = newValue ?? selectedBroker;
                  print(
                      "Selected Broker changed to: $selectedBroker"); // Debug print
                });
              },
              items: brokers.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.deviceName,
              decoration: const InputDecoration(
                labelText: "Device Name",
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.mqttTopic,
              decoration: const InputDecoration(
                labelText: "Topic to subscribe",
                hintText: "e.g /Topic",
                prefixIcon: Icon(
                  Icons.topic_outlined,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.deviceId,
              decoration: const InputDecoration(
                labelText: "Device ID",
                hintText: "Unique device ID",
                prefixIcon: Icon(Icons.perm_identity_outlined),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: controller.deviceLat,
                    decoration: const InputDecoration(
                      labelText: "Latitude",
                      hintText: "e.g 51.5388345",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: TextField(
                    controller: controller.deviceLong,
                    decoration: const InputDecoration(
                      labelText: "Longitude",
                      hintText: "e.g -0.0106886",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.saveIoTDevicesDetails(),
                child: Text("Add Device".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
