import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/features/controllers/add_iot_devices_controller.dart';

class AddIoTBrokersScreen extends StatefulWidget {
  const AddIoTBrokersScreen({super.key});

  @override
  State<AddIoTBrokersScreen> createState() => _AddIoTBrokersScreenState();
}

class _AddIoTBrokersScreenState extends State<AddIoTBrokersScreen> {
  final controller = Get.put(IoTDevicesController());
  String? selectedBroker;
  List<String> brokers = [
    "Add New MQTT Broker"
  ]; // Default option for adding new broker

  // @override
  // void initState() {
  //   super.initState();
  //   loadBrokers();
  // }

  // // void loadBrokers() async {
  // //   // Simulate fetching data from Firestore
  // //   var fetchedBrokers = await controller.createNewBrokerDetails();
  // //   // setState(() {
  // //   //   brokers.addAll(fetchedBrokers);
  // //   // });
  // // }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Add MQTT Broker",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Form(
          key: controller.iotDeviceFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedBroker,
                icon: const Icon(Icons.arrow_downward),
                decoration: const InputDecoration(
                  labelText: "Select Broker",
                  enabledBorder: OutlineInputBorder(),
                ),
                items: brokers.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBroker = newValue;
                  });
                },
              ),
              if (selectedBroker == "Add New MQTT Broker") ...[
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.mqttHost,
                  decoration: const InputDecoration(
                    labelText: "MQTT Broker Host",
                    hintText: "e.g., mqtt.broker.org",
                    prefixIcon: Icon(Icons.link),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.mqttPort,
                  decoration: const InputDecoration(
                    labelText: "Port",
                    hintText: "e.g., 1883",
                    prefixIcon: Icon(Icons.settings_input_component),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.mqttUsername,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.mqttPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.createNewBrokerDetails(),
                  child: const Text("SAVE NEW BROKER"),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
