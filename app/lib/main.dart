import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('MQTT Feeds')), body: MyListView()));
  }
}

class MyListView extends StatefulWidget {
  @override
  ListViewState createState() {
    return ListViewState();
  }
}

class ListViewState extends State<MyListView> {
  late List<String> feeds;
  late mqtt.MqttServerClient client;

  @override
  void initState() {
    super.initState();
    feeds = [];
    startMQTT(); // Call startMQTT method to initialize and connect the MQTT client
  }

  void updateList(String s) {
    setState(() {
      feeds.add(s);
    });
  }

  // Define the startMQTT method
  void startMQTT() async {
    // Initialize the MQTT client
    client = mqtt.MqttServerClient('broker.hivemq.com', '');
    client.port = 1883;

    // Assuming your broker requires a username and password
    String username = 'your_username'; // Replace with your actual username
    String password = 'your_password'; // Replace with your actual password

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    // Check if we are connected
    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      print('MQTT client connected');
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }

    // Subscribe to the topic
    const String topic = 'SCD41-CO2-1';
    client.subscribe(topic, mqtt.MqttQos.atMostOnce);

    // Add the callback for incoming messages
    client.updates!
        .listen((List<mqtt.MqttReceivedMessage<mqtt.MqttMessage>> c) {
      final mqtt.MqttPublishMessage recMess =
          c[0].payload as mqtt.MqttPublishMessage;
      final String message = mqtt.MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message!);

      print('Received message: $message from topic: ${c[0].topic}>');
      updateList(message); // Update the list with the received message
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(feeds[index]),
        );
      },
    );
  }
}
