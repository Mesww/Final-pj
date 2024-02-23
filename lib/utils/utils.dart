import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void httpErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']+'400');
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']+'500');
      break;
    default:
      showSnackBar(context, response.body);
  }
}
