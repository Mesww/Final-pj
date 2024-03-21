import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bus {
  final int id; // Assuming bus ID from the API response (modify if different)
  final int direction;
  final int speed;
  final String serverTime;
  final String trackerTime;
  final String position;

  const Bus({
    required this.id,
    required this.direction,
    required this.speed,
    required this.serverTime,
    required this.trackerTime,
    required this.position,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: int.parse(json['id']), // Assuming ID is a string in the API response
      direction: json['direction'],
      speed: json['speed'],
      serverTime: json['server_time'],
      trackerTime: json['tracker_time'],
      position: json['position'],
    );
  }
}

const String bearerToken =
    'k3wbpy57L4pVQC'; // **Never expose this in real code**

Future<List<Bus>> fetchBus() async {
  final url = Uri.parse('https://www.ppgps171.com/mobile/api/mfutransit');

  final headers = {
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json', // Assuming JSON data exchange
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    String logResponse = response.statusCode.toString();
    print('ResponseStatusCode: $logResponse'); // Check Status Code = 200
    print('ResponseBody: ' + response.body); // Read Data in Array

    // Try parsing the response as JSON
    try {
      final Map<String, dynamic> busData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Bus> buses = [];
      busData.forEach((key, value) {
        buses.add(Bus.fromJson(value));
      });
      return buses;
    } on FormatException catch (e) {
      // Handle the case where the response is not valid JSON
      print('Failed to parse response as JSON: $e');
      throw Exception('Failed to load bus data');
    }
  } else {
    throw Exception(
        'Failed to load bus data (Status Code: ${response.statusCode})');
  }
}

class MyApps extends StatefulWidget {
  const MyApps({super.key});

  @override
  State<MyApps> createState() => _MyAppState();
}

class _MyAppState extends State<MyApps> {
  late Future<List<Bus>> futureBus;

  @override
  void initState() {
    super.initState();
    futureBus = fetchBus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bus Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Bus>>(
            future: futureBus,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                List<Bus>? buses = snapshot.data;
                // print(buses);
                return ListView.builder(
                  itemBuilder: (context, int index) {
                    return Container(
                      child: Text(buses![index].position),
                    );
                  },
                  itemCount: buses?.length ?? 0, // Handle empty list
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
