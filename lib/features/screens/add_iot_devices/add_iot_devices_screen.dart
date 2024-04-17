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
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController topicController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  String _selectedParameter = 'Temperature'; // Default value

  @override
  Widget build(BuildContext context) {
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
                prefixIcon: Icon(Icons.account_tree_outlined),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: topicController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.password_outlined),
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedParameter,
              decoration: InputDecoration(
                labelText: "Select Parameter",
                prefixIcon: Icon(Icons.filter_alt_outlined),
              ),
              items: <String>['Temperature', 'Humidity'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedParameter = newValue!;
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: topicController,
              decoration: InputDecoration(
                labelText: "Topic",
                hintText: "Topic to parameter",
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
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                new Flexible(
                  child: new TextField(
                    decoration: InputDecoration(
                      labelText: "Longitude",
                      hintText: "Like -0.0106886",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Device added with topic: ${topicController.text}");
                },
                child: Text("Add Device".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
