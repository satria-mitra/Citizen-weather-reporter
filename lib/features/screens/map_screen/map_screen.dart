import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; // Controller for Google Map
  final LatLng _center =
      const LatLng(-6.3121994, 106.4245901); // Initial location

  // Marker Set
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() async {
    FirebaseFirestore.instance
        .collection('devices')
        .get()
        .then((querySnapshot) {
      print(
          "Total devices: ${querySnapshot.docs.length}"); // Debug: Number of documents fetched
      querySnapshot.docs.forEach((result) {
        double latitude = double.parse(result.data()['latt'].toString());
        double longitude = double.parse(result.data()['long'].toString());

        print(
            "Device ID: ${result.data()['deviceID']} at ($latitude, $longitude)"); // Debug: Print each device's location

        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(result.data()['deviceID']),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: result.data()['deviceName'],
              snippet: 'ID: ${result.data()['deviceID']}',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ));
        });
      });
    }).catchError((error) {
      print(
          "Error fetching data: $error"); // Debug: Print error if data fetch fails
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IoT Map"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 450,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 9.0,
              ),
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
