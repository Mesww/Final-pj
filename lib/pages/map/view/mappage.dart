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

   final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.05884362541219, 99.89840388818074),
      infoWindow: InfoWindow(title: '1'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(20.05709734818155, 99.89694381071735),
      infoWindow: InfoWindow(title: '2'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(20.054714358618483, 99.89456736656254),
      infoWindow: InfoWindow(title: '3'),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(20.052565215511244, 99.89231798713149),
      infoWindow: InfoWindow(title: '4'),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(20.050816843021277, 99.89121969349162),
      infoWindow: InfoWindow(title: '5'),
    ),
    Marker(
      markerId: MarkerId('6'),
      position: LatLng(20.049137353450433, 99.891250485570452),
      infoWindow: InfoWindow(title: '6'),
    ),
    Marker(
      markerId: MarkerId('7'),
      position: LatLng(20.048397671997282, 99.89320068812843),
      infoWindow: InfoWindow(title: '7'),
    ),
    Marker(
      markerId: MarkerId('8'),
      position: LatLng(20.047264832318994, 99.89314563095694),
      infoWindow: InfoWindow(title: '8'),
    ),
        Marker(
      markerId: MarkerId('9'),
      position: LatLng(20.045737111535473, 99.89152205304603),
      infoWindow: InfoWindow(title: '9'),
    ),
     Marker(
      markerId: MarkerId('10'),
      position: LatLng(20.043881444753783, 99.89348617576454),
      infoWindow: InfoWindow(title: '10'),
    ),
     Marker(
      markerId: MarkerId('11'),
      position: LatLng(20.043919609786567, 99.89490923095694),
      infoWindow: InfoWindow(title: '11'),
    ),
    Marker(
      markerId: MarkerId('12'),
      position: LatLng(20.043311336533844, 99.89529707515575),
      infoWindow: InfoWindow(title: '12'),
    ),
    Marker(
      markerId: MarkerId('13'),
      position: LatLng(20.043845538331563, 99.8934754469289),
      infoWindow: InfoWindow(title: '13'),
    ),
 Marker(
      markerId: MarkerId('14'),
      position: LatLng(20.045659393241642, 99.89133178188165),
      infoWindow: InfoWindow(title: '14'),
    ),
    Marker(
      markerId: MarkerId('15'),
      position: LatLng(20.049391118491396, 99.89111283095696),
      infoWindow: InfoWindow(title: '15'),
    ),
    Marker(
      markerId: MarkerId('16'),
      position: LatLng(20.05083048583872, 99.89115650886787),
      infoWindow: InfoWindow(title: '16'),
    ),
    Marker(
      markerId: MarkerId('17'),
      position: LatLng(20.052689636083315, 99.89234180090831),
      infoWindow: InfoWindow(title: '17'),
    ),
    Marker(
      markerId: MarkerId('18'),
      position: LatLng(20.05473222049373, 99.89448019896511),
      infoWindow: InfoWindow(title: '18'),
    ),
    Marker(
      markerId: MarkerId('19'),
      position: LatLng(20.056897650552507, 99.89711855304603),
      infoWindow: InfoWindow(title: '19'),
    ),
    Marker(
      markerId: MarkerId('20'),
      position: LatLng(20.05806378447924, 99.89787541746388),
      infoWindow: InfoWindow(title: '20'),
    ),
    Marker(
      markerId: MarkerId('21'),
      position: LatLng(20.058966957817436, 99.8995173298247),
      infoWindow: InfoWindow(title: '21'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: _pGooglePlex, zoom: 16.0),
                  markers: Set<Marker>.of(_marker),),
      floatingActionButton: Builder(builder: (context) => Buslinebutton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
