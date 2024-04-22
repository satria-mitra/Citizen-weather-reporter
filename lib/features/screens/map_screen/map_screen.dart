import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weathershare/constants/colors.dart';
import 'package:weathershare/constants/sizes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; // Controller for Google Map
  final LatLng _center =
      const LatLng(-6.3121994, 106.4245901); // Initial location
  String _deviceData = "Select a marker to show data"; // Default text
  final FirebaseDatabase database = FirebaseDatabase.instance;

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
      querySnapshot.docs.forEach((result) {
        double latitude = double.parse(result.data()['latt'].toString());
        double longitude = double.parse(result.data()['long'].toString());

        // Create a new marker with an onTap event
        Marker newMarker = Marker(
          markerId: MarkerId(result.data()['deviceID']),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: result.data()['deviceName'],
            snippet: 'ID: ${result.data()['deviceID']}',
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            _onMarkerTapped(result.data()[
                'deviceID']); // Call the _onMarkerTapped function with the device ID
          },
        );

        setState(() {
          _markers.add(newMarker);
        });
      });
    }).catchError((error) {
      print("Error fetching data: $error");
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMarkerTapped(String deviceId) {
    database
        .ref()
        .child('devices')
        .child(deviceId)
        .orderByKey()
        .limitToLast(1) // Fetches the most recent date entry
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        var dates = Map<String, dynamic>.from(event.snapshot.value as Map);
        String latestDate = dates.keys.last; // Safely get the most recent date

        database
            .ref()
            .child('devices')
            .child(deviceId)
            .child(latestDate)
            .orderByKey()
            .limitToLast(1) // Fetches the most recent time entry
            .once()
            .then((DatabaseEvent timeEvent) {
          if (timeEvent.snapshot.exists && timeEvent.snapshot.value != null) {
            var times =
                Map<String, dynamic>.from(timeEvent.snapshot.value as Map);
            String latestTime =
                times.keys.last; // Safely get the most recent time
            var data = Map<String, dynamic>.from(times[latestTime] as Map);

            // Safely access temperature and humidity with null checks
            String temp =
                data['temp_avg'] != null ? "${data['temp_avg']}°C" : "N/A";
            String rh = data['rh_avg'] != null ? "${data['RH_avg']}%" : "N/A";

            setState(() {
              _deviceData =
                  "Date: $latestDate\nTime: $latestTime\nTemp: $temp, RH: $rh";
            });
          } else {
            setState(() {
              _deviceData = "No time data available for this date";
            });
          }
        });
      } else {
        setState(() {
          _deviceData = "No date data available for this device";
        });
      }
    }).catchError((error) {
      print("Error in fetching data: $error");
    });
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
            height: 400,
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
                onTap: (LatLng location) {
                  setState(() {
                    _deviceData = "Select a marker to show data";
                  });
                }),
          ),
          Expanded(
              child: Padding(
                  // This Padding widget adds padding around the Card
                  padding: const EdgeInsets.all(defaultSize),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                          title: Text('Device Name - Device ID'),
                          subtitle: Text('Date - Time.'),
                        ),
                        const ListTile(
                          title: Text('Temperature : '),
                          leading: Icon(Icons.device_thermostat_outlined),
                        ),
                        const ListTile(
                          title: Text('Humidity : '),
                          leading: Icon(Icons.waterfall_chart_outlined),
                        ),
                        TextButton(
                          child: const Text(
                            'LISTEN',
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () {/* ... */},
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
