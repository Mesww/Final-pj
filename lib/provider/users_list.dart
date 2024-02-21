import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class usersProvider extends ChangeNotifier {
  final httpClient = http.Client();
  late List<dynamic> usersData;
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  //get request
  Future fetchData() async {
    final Uri restAPIURL =
        Uri.parse("https://senior-pj-fb736225a696.herokuapp.com/");
    http.Response response = await httpClient.get(restAPIURL);
    final Map parsedData = await json.decode(response.body.toString());
    usersData = parsedData['data'];
    print(usersData);
  }

  //Post request
  Future addData(Map<String, String> body) async {
    final Uri restAPIURL =
        Uri.parse("https://senior-pj-fb736225a696.herokuapp.com/add");

      http.Response response = await httpClient.post(restAPIURL,
          headers: customHeaders, body: jsonEncode(body));
    return response.body;
  }

  //Delete request
  Future deleteData(String _id) async {
    final Uri restAPIURL =
        Uri.parse("https://senior-pj-fb736225a696.herokuapp.com/delete");

    http.Response response = await httpClient.delete(restAPIURL,
        headers: customHeaders, body: jsonEncode({"_id": _id}));
    return response.body;
  }

  //update request(Put)
  Future updateData(Map<String, String> data) async {
    final Uri restAPIURL =
        Uri.parse("https://senior-pj-fb736225a696.herokuapp.com/update");

    http.Response response = await httpClient.put(restAPIURL,
        headers: customHeaders, body: jsonEncode(data));
    print(response.body);
    return response.body;
  }
}
