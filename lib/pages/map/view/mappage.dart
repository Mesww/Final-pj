import 'dart:async';

import 'package:flutter/material.dart';
import 'package:final_pj/pages/map/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mappage extends StatefulWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  Completer<GoogleMapController> _coontroller = Completer();
  
  static const LatLng _pGooglePlex = LatLng(20.046653, 99.892122);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _pGooglePlex, zoom: 16.0)),
      floatingActionButton: Builder(builder: (context) => Buslinebutton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
