import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/controllers/add_broker_controller.dart';

class AddIoTBrokersScreen extends StatefulWidget {
  const AddIoTBrokersScreen({super.key});

  @override
  State<AddIoTBrokersScreen> createState() => _AddIoTBrokersScreenState();
}

class _AddIoTBrokersScreenState extends State<AddIoTBrokersScreen> {
  final AddBrokersController controller = Get.put(AddBrokersController());
  String? selectedBroker;
  String? selectedDevice;

  List<String> brokers = ["Add New MQTT Broker"];
  List<String> devices = ["Add New IoT Device"];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadBrokers();
    //loadDevices();
  }

  void loadBrokers() async {
    setLoading(true);
    var fetchedBrokers = await controller.fetchBrokerNames();
    setLoading(false);
    setState(() {
      brokers = ["Add New MQTT Broker"] + fetchedBrokers;
    });
  }

  // void loadDevices() async {
  //   setLoading(true);
  //   var fetchedDevices = await controller.fetchDeviceNames();
  //   setLoading(false);
  //   setState(() {
  //     devices = ["Add New IoT Device"] + fetchedDevices;
  //   });
  // }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF272727) : const Color(0xffffffff),
      appBar: AppBar(
        title: const Text("Add MQTT Brokers & Devices"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: controller.brokersFormKey,
                child: Column(
                  children: [
                    buildDropdown("Select Broker", brokers, selectedBroker,
                        (val) {
                      setState(() {
                        selectedBroker = val;
                      });
                      controller
                          .clearBrokerFields(); // Clear fields when changing selection
                      if (val != "Add New MQTT Broker") {
                        controller.loadBrokerDetails(val!);
                      }
                    }),
                    if (selectedBroker == "Add New MQTT Broker") ...[
                      buildTextField("MQTT Name", controller.mqttName),
                      buildTextField("MQTT Broker Host", controller.mqttHost),
                      buildTextField("Port", controller.mqttPort),
                      buildTextField("Username", controller.mqttUsername),
                      buildPasswordField(controller),
                      buildSaveButton("Save Broker", () async {
                        await controller.saveBrokerDetails();
                      }),
                    ],
                    const SizedBox(height: 30),
                    buildDropdown("Select Device", devices, selectedDevice,
                        (val) {
                      setState(() {
                        selectedDevice = val;
                      });
                      controller
                          .clearDeviceFields(); // Clear fields when changing selection
                      if (val != "Add New IoT Device") {
                        controller.loadDeviceDetails(val!);
                      }
                    }),
                    if (selectedDevice == "Add New IoT Device") ...[
                      buildTextField("Device Name", controller.deviceName),
                      buildTextField("Device ID", controller.deviceID),
                      buildTextField("Topic", controller.deviceTopic),
                      buildTextField("Latitude", controller.deviceLat),
                      buildTextField("Longitude", controller.deviceLong),
                      buildSaveButton("Save Device", () async {
                        await controller.saveDeviceDetails();
                      }),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String? currentValue,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => onChanged(value),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.edit),
        ),
      ),
    );
  }

  Widget buildPasswordField(AddBrokersController controller) {
    return Obx(() => TextFormField(
          controller: controller.mqttPassword,
          obscureText: controller.hidePassword.value,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(controller.hidePassword.value
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () => controller.hidePassword.toggle(),
            ),
            border: const OutlineInputBorder(),
          ),
        ));
  }

  Widget buildSaveButton(String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
