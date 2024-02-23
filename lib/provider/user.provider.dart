import 'package:flutter/material.dart';
import 'package:final_pj/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(id: '', studentid: '', email: '', token: '', password: '');

  User get user => _user;

  void setUser(String user) {
    //? fromJson from model
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
