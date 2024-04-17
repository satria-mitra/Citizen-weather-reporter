import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/common_widgets/form_header_widget.dart'; // Assuming this is correctly implemented
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
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? secondaryColor : primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back button
        title: Text(
          "Add IoT Device", // Ensure 'userProfile' is defined in your constants or replace it with a string
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        // Changed from child to body and wrapped content in SingleChildScrollView
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          children: [
            Text(
              "Add MQTT Broker Details",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: "MQTT Broker Host",
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: deviceNameController,
              decoration: const InputDecoration(
                labelText: "Port",
                prefixIcon: Icon(Icons.devices),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: topicController,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.account_box_outlined),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.vpn_key),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: topicController,
              decoration: InputDecoration(
                labelText: "Topic",
                prefixIcon: Icon(Icons.topic),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Add Devices Metadata",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: topicController,
              decoration: InputDecoration(
                labelText: "Device Name",
                prefixIcon: Icon(Icons.file_copy_outlined),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(login.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
