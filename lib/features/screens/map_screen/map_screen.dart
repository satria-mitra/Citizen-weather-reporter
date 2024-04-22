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
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-6.3121994, 106.4245901);
  String _deviceData = "Select a marker to show data";
  String _deviceName = "";
  String _date = "";
  String _time = "";
  String _temperature = "";
  String _humidity = "";
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
        .limitToLast(1)
        .once()
        .then((DatabaseEvent event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        Map<String, dynamic> dates =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        String latestDate = dates.keys.last;

        database
            .ref()
            .child('devices')
            .child(deviceId)
            .child(latestDate)
            .orderByKey()
            .limitToLast(1)
            .once()
            .then((DatabaseEvent timeEvent) {
          if (timeEvent.snapshot.exists && timeEvent.snapshot.value != null) {
            Map<String, dynamic> times =
                Map<String, dynamic>.from(timeEvent.snapshot.value as Map);
            String latestTime = times.keys.last;
            Map<String, dynamic> data =
                Map<String, dynamic>.from(times[latestTime] as Map);

            setState(() {
              _deviceName =
                  deviceId; // Assuming deviceID is used as a part of device name
              _date = latestDate;
              _time = latestTime;
              _temperature = data['temp_avg']?.toString() ?? "N/A";
              _humidity = data['rh_avg']?.toString() ?? "N/A";
            });
          }
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
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Device Name: $_deviceName'),
                          subtitle: Text('Date: $_date - Time: $_time'),
                        ),
                        ListTile(
                          title: Text('Temperature: $_temperature °C'),
                          leading: Icon(Icons.device_thermostat_outlined),
                        ),
                        ListTile(
                          title: Text('Humidity: $_humidity %'),
                          leading: Icon(Icons.waterfall_chart_outlined),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: const Text('VIEW MORE DATA'),
                            onPressed: () {/* ... */},
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
