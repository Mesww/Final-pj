import 'package:flutter/material.dart';

class ChangeRoute extends ChangeNotifier {
  String route = "";
  void ChangeselectedRoute(String newRoute) {
    route = newRoute;
    notifyListeners();
  }
}
