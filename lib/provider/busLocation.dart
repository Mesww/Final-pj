import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class busLocation extends ChangeNotifier {
  final httpClient = http.Client();
  late List<dynamic> busData;
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
    "Authorization: Bearer k3wbpy57L4pVQC"
  };

  //get request
  Future fetchData() async {
    final Uri restAPIURL =
        Uri.parse("https://www.ppgps171.com/mobile/api/mfutransit");
    http.Response response = await httpClient.get(restAPIURL, headers: customHeaders);
    final Map parsedData = await json.decode(response.body.toString());
    busData = parsedData['data'];
    print(busData);
  }
}
