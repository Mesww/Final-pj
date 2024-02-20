import 'dart:async';

import 'package:final_pj/pages/map/widgets/const.dart';
import 'package:final_pj/provider/changeRoute.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/map/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Mappage extends StatefulWidget {
  Mappage({
    Key? key,
  }) : super(key: key);
  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.050236851378024, 99.89456487892942),
    zoom: 16,
  );

  String selectedRoute = "";
  final Set<Marker> _markers = {};

// Route 1
  Polyline _polylineR1 = const Polyline(polylineId: PolylineId("polylineR1"));
  // Route 2
  Polyline _polylineR2 = const Polyline(polylineId: PolylineId("polylineR2"));

  @override
  void initState() {
    super.initState();
    _markers.addAll(list);
    _setPolylinePoints();
  }

  void _setPolylinePoints() {
    //Import form const.dart
    _polylineR1 = _polylineR1.copyWith(
      pointsParam: polylinePointsRoute1,
      colorParam: Colors.blue,
    );
    _polylineR2 = _polylineR2.copyWith(
      pointsParam: polylinePointsRoute2,
      colorParam: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    String selectedRoute = Provider.of<ChangeRoute>(context).route;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: _markers,
              polylines: {
                selectedRoute == "route1" ? _polylineR1 : _polylineR2
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           selectedRoute = "route1";
          //         });
          //       },
          //       child: const Text("Show Route 1"),
          //     ),
          //     const SizedBox(width: 10),
          //     ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           selectedRoute = "route2";
          //         });
          //       },
          //       child: const Text("Show Route 2"),
          //     ),
          //   ],
          // ),
        ],
      ),
      floatingActionButton: Builder(builder: (context) => Buslinebutton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
