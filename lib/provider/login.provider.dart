import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.service.dart';

class Form_login extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();
  final studentid = TextEditingController();
  final password = TextEditingController();
  late bool obscure_password = true;
  late String studentID;
  late String _password;
  final AuthService authService = AuthService();

  GlobalKey<FormState> get_formkey() => this.formkey;
  TextEditingController get_studentid() => this.studentid;
  TextEditingController get_password() => this.password;
  bool get_obscure_password() => this.obscure_password;
  String get_studentID() => this.studentID;
  String get__password() => this._password;

  void loginUser(BuildContext context) {
    print(studentid.text + password.text);
    authService.signInUser(
      context: context,
      studentid: studentid.text,
      password: password.text,
    );
  }

  void set_obscure_password_login(bool obscure_password) {
    this.obscure_password = obscure_password;
    notifyListeners();
  }

  void set_studentID(String studentID) {
    this.studentID = studentID;
    notifyListeners();
  }

  void set__password(String password) {
    this._password = password;
    notifyListeners();
  }
}
