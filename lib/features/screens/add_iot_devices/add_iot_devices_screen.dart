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
                hintText: "mqtt.broker.org",
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: deviceNameController,
              decoration: const InputDecoration(
                labelText: "Port",
                hintText: "1883 / 1884",
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
              //obscureText: controller.hidePassword.value,
              //controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: password,
                hintText: password,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_sharp),
                ),
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
                prefixIcon: Icon(Icons.badge_outlined),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                      decoration: InputDecoration(
                          labelText: "Latitude",
                          hintText: "Like 51.5388345",
                          prefixIcon: Icon(Icons.location_on_outlined))),
                ),
                SizedBox(
                  width: 10.0,
                ),
                new Flexible(
                  child: new TextField(
                      decoration: InputDecoration(
                          labelText: "Longitude",
                          hintText: "Like -0.0106886",
                          prefixIcon: Icon(Icons.location_on_outlined))),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Add Device".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
