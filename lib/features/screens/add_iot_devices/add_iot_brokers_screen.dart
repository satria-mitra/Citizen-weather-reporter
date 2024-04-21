import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/features/controllers/add_broker_controller.dart';
import 'package:weathershare/features/screens/add_iot_devices/add_iot_devices_screen.dart';

class AddIoTBrokersScreen extends StatefulWidget {
  const AddIoTBrokersScreen({super.key});

  @override
  State<AddIoTBrokersScreen> createState() => _AddIoTBrokersScreenState();
}

class _AddIoTBrokersScreenState extends State<AddIoTBrokersScreen> {
  final controller = Get.put(AddBrokersController());
  String? selectedBroker;

  List<String> brokers = [
    "Add New MQTT Broker"
  ]; // Initial list with only the 'Add New MQTT Broker' option

  @override
  void initState() {
    super.initState();
    loadBrokers();
  }

  void loadBrokers() async {
    var fetchedBrokers = await controller.fetchBrokerNames();
    setState(() {
      // Ensures 'Add New MQTT Broker' is always the first item and it adds fetched brokers next
      brokers = ["Add New MQTT Broker"] +
          fetchedBrokers
              .where((broker) => broker != "No Brokers Found")
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        title: Text("Add MQTT Broker",
            style: Theme.of(context).textTheme.headlineMedium),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultSize),
        child: Form(
          key: controller.brokersFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedBroker,
                decoration: const InputDecoration(
                    labelText: "Select Broker",
                    enabledBorder: OutlineInputBorder()),
                items: brokers.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBroker = newValue;
                  });
                  if (newValue == "Add New MQTT Broker") {
                    controller.clearFields();
                  } else {
                    controller.loadBrokerDetails(
                        newValue!); // Load details for editing
                  }
                },
              ),
              if (selectedBroker == "Add New MQTT Broker") ...[
                const SizedBox(height: 16),
                buildTextField("MQTT Name", controller.mqttName),
                const SizedBox(height: 16),
                buildTextField("MQTT Broker Host", controller.mqttHost),
                const SizedBox(height: 16),
                buildTextField("Port", controller.mqttPort),
                const SizedBox(height: 16),
                buildTextField("Username", controller.mqttUsername),
                const SizedBox(height: 16),
                buildPasswordField(),
                const SizedBox(height: 16),
                buildSaveButton(context),
              ],
              if (selectedBroker != null &&
                  selectedBroker != "Add New MQTT Broker") ...[
                const SizedBox(height: 16),
                buildBrokerDetails(),
                const SizedBox(height: 16),
                buildNextButton(context)
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.edit),
      ),
    );
  }

  Widget buildPasswordField() {
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

  Widget buildSaveButton(BuildContext context) {
    return ElevatedButton(
      child: const Text("SAVE NEW BROKER"),
      onPressed: () async {
        await controller.saveBrokerDetails();
        if (controller.brokersFormKey.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddIoTDevicesScreen(
                      initialBroker: controller.mqttName.text)));
        }
      },
    );
  }

  Widget buildBrokerDetails() {
    return Column(
      children: [
        buildTextField("MQTT Name", controller.mqttName),
        const SizedBox(height: 16),
        buildTextField("MQTT Broker Host", controller.mqttHost),
        const SizedBox(height: 16),
        buildTextField("Port", controller.mqttPort),
        const SizedBox(height: 16),
        buildTextField("Username", controller.mqttUsername),
        const SizedBox(height: 16),
        buildPasswordField(),
      ],
    );
  }

  Widget buildNextButton(BuildContext context) {
    return ElevatedButton(
      child: const Text("NEXT"),
      onPressed: () async {
        await controller.saveBrokerDetails();
        if (controller.brokersFormKey.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddIoTDevicesScreen(
                      initialBroker: controller.mqttName.text)));
        }
      },
    );
  }
}
