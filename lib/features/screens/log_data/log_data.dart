import 'package:flutter/material.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_database/firebase_database.dart';

class LogDataScreen extends StatefulWidget {
  const LogDataScreen({super.key});

  @override
  State<LogDataScreen> createState() => _LogDataScreenState();
}

class _LogDataScreenState extends State<LogDataScreen> {
  final TextEditingController controller = TextEditingController();
  String? selectedDevice;
  List<String> devices = [
    "Device 1",
    "Device 2",
    "Device 3"
  ]; // Example list of devices

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        backgroundColor: isDark ? secondaryColor : primaryColor,
        appBar: AppBar(
          title: Text("Data Log"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownSearch<String>(),
        ));
  }
}
