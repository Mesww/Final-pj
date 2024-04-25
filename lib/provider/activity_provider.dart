import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class actiivity_provider extends ChangeNotifier {
  late String studentId_act;
  late String location_act;
  late String marker_act;
  late String date_act;
  late String time_act;

  String get_studentId_act() => this.studentId_act;
  String get_location_act() => this.location_act;
  String get_marker_act() => this.marker_act;
  String get_date_act() => this.date_act;
  String get_time_act() => this.time_act;

  void set_studentId_act(String studentId_act) {
    this.studentId_act = studentId_act;
    notifyListeners();
  }

  void set_location_act(String location_act) {
    this.location_act = location_act;
    notifyListeners();
  }

  void set_marker_act(String marker_act) {
    this.marker_act = marker_act;
    notifyListeners();
  }

  void set_date_act(String date_act) {
    this.date_act = date_act;
    notifyListeners();
  }

  void set_time_act(String time_act) {
    this.time_act = time_act;
    notifyListeners();
  }

  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  final httpClient = http.Client();

  Future createActivity(Map<String, String> body) async {
    final Uri restAPIURL =
        Uri.parse("http://34.124.142.184/activity");
    http.Response response = await httpClient.post(restAPIURL,
        headers: customHeaders, body: jsonEncode(body));
    print(response.statusCode);
    return response.body;
  }
}
