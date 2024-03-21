import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bus {
  final int? id;
  final int? direction;
  final int? speed;
  final String? serverTime;
  final String? trackerTime;
  final String? position;

  const Bus({
    required this.id,
    required this.direction,
    required this.speed,
    required this.serverTime,
    required this.trackerTime,
    required this.position,
  });
}

const String bearerToken = 'k3wbpy57L4pVQC';

Future<List<Bus>> fetchBus() async {
  var url = Uri.parse('https://www.ppgps171.com/mobile/api/mfutransit');

  final headers = {
    'Authorization': 'Bearer $bearerToken',
    'Content-Type': 'application/json',
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    List<Bus> buses = [];
    for (var key in jsonData['data'].keys) {
      // Access data by key  (or any other key from the response)
      final eachData = jsonData['data'][key];
      final bus = Bus(
        id: int.tryParse(key), // Attempt to convert key to int for id
        direction: eachData['direction'],
        speed: eachData['speed'],
        serverTime: eachData['server_time'],
        trackerTime: eachData['tracker_time'],
        position: eachData['position'],
      );
      buses.add(bus);
    }
    return buses;
  } else {
    throw Exception('Failed to fetch bus data');
  }
}

Future busFuture = fetchBus();

class MyApps extends StatefulWidget {
  const MyApps({super.key});

  @override
  State<MyApps> createState() => _MyAppState();
}

class _MyAppState extends State<MyApps> {
  @override
  void initState() {
    super.initState();
    // Call fetchBus() here to avoid unnecessary data fetching on every build
    fetchBus();
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
        body: FutureBuilder<List<Bus>>(
          future: fetchBus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final buses = snapshot.data!;
              return ListView.builder(
                itemCount: buses.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final bus = buses[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text('ไอดี ${bus.id?.toString()}'),
                          Text('เวลาติดตาม ${bus.trackerTime!.toString()}'),
                          Text('เวลาเซิฟ ${bus.serverTime!.toString()}'),
                          Text('ตำแหน่ง ${bus.position!.toString()}'),
                          Text('ทิศทาง ${bus.direction!.toString()}'),
                          Text('ความเร็ว ${bus.speed!.toString()}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
