import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';
import 'package:weathershare/features/controllers/add_iot_devices_controller.dart';

class AddIoTDevicesScreen extends StatefulWidget {
  const AddIoTDevicesScreen({super.key});

  @override
  State<AddIoTDevicesScreen> createState() => _AddIoTDevicesScreenState();
}

class _AddIoTDevicesScreenState extends State<AddIoTDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IoTDevicesController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              "Add MQTT Broker Details",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.mqttHost,
              decoration: const InputDecoration(
                labelText: "MQTT Broker Host",
                hintText: "mqtt.broker.org",
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.mqttPort,
              decoration: const InputDecoration(
                labelText: "Port",
                hintText: "1883 / 1884",
                prefixIcon: Icon(Icons.devices),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.mqttUsername,
              decoration: const InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.account_tree_outlined),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => TextFormField(
                obscureText: controller.hidePassword.value,
                controller: controller.mqttPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint),
                  labelText: password,
                  hintText: password,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: const Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.mqttTopic,
              decoration: const InputDecoration(
                labelText: "Topic",
                hintText: "Topic to parameter",
                prefixIcon: Icon(Icons.topic),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Add Devices Metadata",
              style: Theme.of(context).textTheme.titleMedium,
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
              controller: controller.deviceId,
              decoration: const InputDecoration(
                labelText: "Device ID",
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
                      hintText: "Like 51.5388345",
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
                      hintText: "Like -0.0106886",
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
                onPressed: () => controller.addBrokerDetails(),
                child: Text("Add Device".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
