import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(51.540992, -0.015719); // Initial location

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
                  Tab(text: "BLE Map"),
                  Tab(text: "IoT Map"),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text("Content for BLE Map"), // Placeholder for BLE Map tab
            ),
            Column(
              children: [
                SizedBox(
                  height: 300, // Define the height of the map area
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 15.0,
                    ),
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true, // Enable zoom gestures
                    scrollGesturesEnabled:
                        true, // Enable scroll gestures (panning)
                    rotateGesturesEnabled: true, // Optional: Allow map rotation
                    tiltGesturesEnabled:
                        true, // Enable scroll gestures (panning)
                  ),
                ),
                // More widgets can be added here if needed
              ],
            )
          ],
        ),
      ),
    );
  }
}
