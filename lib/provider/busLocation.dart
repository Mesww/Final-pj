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

class busLocation extends ChangeNotifier {
  final httpClient = http.Client();

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
}
