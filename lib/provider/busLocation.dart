import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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


