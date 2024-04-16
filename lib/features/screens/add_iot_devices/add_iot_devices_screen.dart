import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/image_strings.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:weathershare/constants/text_string.dart';

class AddIoTDevicesScreen extends StatefulWidget {
  const AddIoTDevicesScreen({Key? key}) : super(key: key);

  @override
  _AddIoTDevicesScreenState createState() => _AddIoTDevicesScreenState();
}

class _AddIoTDevicesScreenState extends State<AddIoTDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              const FormHeaderWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                image: signUpImage, // Assuming you have a relevant image
                title: "Add MQTT Device",
                subTitle: "Configure your IoT devices",
              ),
              _AddIoTDevicesForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddIoTDevicesForm extends StatelessWidget {
  _AddIoTDevicesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceNameController = TextEditingController();
    final topicController = TextEditingController();
    final urlController = TextEditingController();
    final keyController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: deviceNameController,
              decoration: const InputDecoration(
                label: Text("Device Name"),
                prefixIcon: Icon(Icons.devices),
              ),
            ),
            const SizedBox(height: formHeight),
            TextFormField(
              controller: topicController,
              decoration: const InputDecoration(
                label: Text("MQTT Topic"),
                prefixIcon: Icon(Icons.topic),
              ),
            ),
            const SizedBox(height: formHeight),
            TextFormField(
              controller: urlController,
              decoration: const InputDecoration(
                label: Text("Broker URL"),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: formHeight),
            TextFormField(
              controller: keyController,
              decoration: const InputDecoration(
                label: Text("Device Key"),
                prefixIcon: Icon(Icons.vpn_key),
              ),
            ),
            const SizedBox(height: formHeight),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logic to handle adding the device
                  print("Device added!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryColor, // you might want to adjust colors
                  textStyle: const TextStyle(fontSize: 16),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text("ADD DEVICE",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
