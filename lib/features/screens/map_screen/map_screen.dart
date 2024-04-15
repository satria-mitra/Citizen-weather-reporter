import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; // Controller for Google Map
  final LatLng _center = const LatLng(51.540992, -0.015719); // Initial location

  // Marker Set
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Initialize markers
    _markers.add(
      Marker(
        markerId: MarkerId('mainMarker'),
        position: _center, // Marker position
        infoWindow: InfoWindow(
          // Popup info
          title: 'Marker in London',
          snippet: 'This is a snippet',
        ),
        icon: BitmapDescriptor.defaultMarker, // Default icon (red)
      ),
    );

    // Add another marker with a different color
    _markers.add(
      Marker(
        markerId: MarkerId('secondMarker'),
        position: LatLng(51.540288, -0.015204), // Slightly different location
        infoWindow: InfoWindow(
          title: 'Second Marker',
          snippet: 'Different color marker',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), // Blue color marker
      ),
    );
  }

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
                  height: 450, // Define the height of the map area
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 15.0,
                    ),
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    markers:
                        _markers, // Assign marker set to the GoogleMap widget
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
