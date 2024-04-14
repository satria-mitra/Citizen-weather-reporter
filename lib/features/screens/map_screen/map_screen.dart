import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // No back button

          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: "BLE Map",
                  ),
                  Tab(
                    text: "IoT Map",
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(),
            ),
            Center(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
