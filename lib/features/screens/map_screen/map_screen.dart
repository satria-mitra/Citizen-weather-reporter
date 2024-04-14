import 'package:flutter/material.dart';

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
                    text: "Chats",
                  ),
                  Tab(
                    text: "Calls",
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("Chats"),
            ),
            Center(
              child: Text("Calls"),
            ),
          ],
        ),
      ),
    );
  }
}
