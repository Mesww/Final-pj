import 'package:final_pj/provider/busline_provider.dart';
import 'package:flutter/material.dart';
// import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'fab_circular_menu.dart';

class Buslinebutton extends StatelessWidget {
  const Buslinebutton({Key? key}) : super(key: key);

  // String IsOpened = "No";
  // String BtnText = "OpenMenu";
  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var busline_provider_get = context.watch<Busline_provider>();
    var busline_provider_set = context.read<Busline_provider>();
    var itemsActionBar = [
      FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.red,
        child: Icon(MdiIcons.numeric1),
      ),
      FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(MdiIcons.numeric2),
      ),
    ];
    return FabCircularMenu(
        key: busline_provider_get.get_fabKey(),
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
            busline_provider_set.set_IsOpend("Yes");
            // setState(() {
            //   IsOpened = "Yes";
            // });
          } else {
            busline_provider_set.set_IsOpend("Yes");
            // setState(() {
            //   IsOpened = "No";
            // });
          }
        },
        children: itemsActionBar);
  }
}