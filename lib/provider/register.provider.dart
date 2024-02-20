import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Register_provider extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  late bool obscure_password_register = true;
  late bool obscure_re_password_register = true;
  final studentid_register = TextEditingController();
  final password_register = TextEditingController();
  final re_password_register = TextEditingController();
  late String studentID_register;
  late String _password_register;
  late String _re_password_register;

  GlobalKey<FormState> get_formkey() => this.formkey;
  TextEditingController get_studentid_register() => this.studentid_register;
  TextEditingController get_password_register() => this.password_register;
  TextEditingController get_re_password_register() => this.re_password_register;
  bool get_obscure_password_register() => this.obscure_password_register;
  bool get_obscure_re_password_register() => this.obscure_re_password_register;
  String get_studentID_register() => this.studentID_register;
  String get__password_register() => this._password_register;
  String get__re_password_register() => this._re_password_register;

  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };

  final httpClient = http.Client();

  void set_obscure_password(bool obscure_password_register) {
    this.obscure_password_register = obscure_password_register;
    notifyListeners();
  }

  void set_obscure_re_password(bool obscure_re_password_register) {
    this.obscure_re_password_register = obscure_re_password_register;
    notifyListeners();
  }

  void set_studentID_register(String studentID_register) {
    this.studentID_register = studentID_register;
    notifyListeners();
  }

  void set__password_register(String password_register) {
    this._password_register = password_register;
    notifyListeners();
  }

  void set__re_password_register(String re_password_register) {
    this._re_password_register = re_password_register;
    notifyListeners();
  }

  Future createUser(Map<String, String> body) async {
    final Uri restAPIURL =
        Uri.parse("https://server-api-final-f47d00dcc1f8.herokuapp.com/register");

    http.Response response = await httpClient.post(restAPIURL,
        headers: customHeaders, body: jsonEncode(body));
    print(response.statusCode);
    return response.body;
  }
}
