import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/map/widgets/fab_circular_menu.dart';

class Busline_provider extends ChangeNotifier {
  String IsOpened = "No";
  String BtnText = "OpenMenu";
  GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  void set_IsOpend(String IsOpened) {
    this.IsOpened = IsOpened;
    notifyListeners();
  }

  void set_BtnText(String BtnText) {
    this.BtnText = BtnText;
    notifyListeners();
  }

  String get_IsOpend() {
    return IsOpened;
  }
  String get_BtnText() {
    return BtnText;
  }

  GlobalKey<FabCircularMenuState> get_fabKey(){
  return fabKey;
}

}
