import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:final_pj/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Register_provider extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  late bool obscure_password_register = true;
  late bool obscure_re_password_register = true;
  final _email_register = TextEditingController();
  final studentid_register = TextEditingController();
  final password_register = TextEditingController();
  final re_password_register = TextEditingController();
  final AuthService authService = AuthService();

  late String studentID_register;
  late String _password_register;
  late String _re_password_register;

  TextEditingController email_register() => _email_register;
  GlobalKey<FormState> get_formkey() => this.formkey;
  TextEditingController get_studentid_register() => this.studentid_register;
  TextEditingController get_password_register() => this.password_register;
  TextEditingController get_re_password_register() => this.re_password_register;
  bool get_obscure_password_register() => this.obscure_password_register;
  bool get_obscure_re_password_register() => this.obscure_re_password_register;
  String get_studentID_register() => this.studentID_register;
  String get__password_register() => this._password_register;
  String get__re_password_register() => this._re_password_register;

  final httpClient = http.Client();

  void signupUser(context) {
    print(studentid_register.text);
    authService.signUpUser(
        context: context,
        studentid: this.studentid_register.text,
        email: this.email_register().text,
        password: this.password_register.text,
        );
  }

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
}
