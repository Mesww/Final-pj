import 'package:flutter/material.dart';
// import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'fab_circular_menu.dart';

class Buslinebutton extends StatefulWidget {
  const Buslinebutton({Key? key}) : super(key: key);

  @override
  _BuslinebuttonState createState() => _BuslinebuttonState();
}

class _BuslinebuttonState extends State<Buslinebutton> {
  int Counter = 0;
  String IsOpened = "No";
  String BtnText = "OpenMenu";
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var itemsActionBar = [
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Icon(MdiIcons.numeric1),
      ),
      FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(MdiIcons.numeric2),
      ),
    ];
    return FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomCenter,
        ringColor: Colors.white,
        ringDiameter: 200,
        ringWidth: 0,
        fabSize: 50.0,
        fabElevation: 8.0,
        fabColor: Theme.of(context).primaryColorLight,
        fabOpenIcon: Icon(Icons.navigation_rounded, color: Colors.white),
        fabCloseIcon: Icon(Icons.close, color: Colors.white),
        fabMargin: const EdgeInsets.all(20.0),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (isOpen) {
          if (isOpen) {
            setState(() {
              IsOpened = "Yes";
            });
          } else {
            setState(() {
              IsOpened = "No";
            });
          }
        },
        children: itemsActionBar );
  }
}
