import 'dart:async';

import 'package:final_pj/pages/login/login.dart';
import 'package:final_pj/pages/map/widgets/const.dart';
import 'package:final_pj/pages/map/widgets/fab_circular_menu.dart';
import 'package:final_pj/provider/changeRoute.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/map/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mappage extends StatefulWidget {
  Mappage({
    Key? key,
  }) : super(key: key);
  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.050236851378024, 99.89456487892942),
    zoom: 16,
  );
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position>? _positionStream;
  String selectedRoute = "";
  final Set<Marker> _markers = {};

  final double _proximityThreshold = 5;

  // กำหนด State สำหรับ Location ของ User
  late LatLng _userLocation = LatLng(20.050236851378024, 99.89456487892942);

// Route 1
  Polyline _polylineR1 = const Polyline(polylineId: PolylineId("polylineR1"));
  // Route 2
  Polyline _polylineR2 = const Polyline(polylineId: PolylineId("polylineR2"));

  Polyline _polylineR0 = const Polyline(polylineId: PolylineId("polylineR0"));

  @override
  void initState() {
    super.initState();
    _markers.addAll(list);
    _setPolylinePoints();
    _requestLocationPermission();
    _getUserLocation();
    
    // distace display realtime
    _positionStream = Geolocator.getPositionStream().listen((position) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        // print(_userLocation);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream?.cancel(); // Cancel the stream subscription
  }

  //ลากเส้นทาง
  void _setPolylinePoints() {
    //Import form const.dart
    _polylineR1 = _polylineR1.copyWith(
      pointsParam: polylinePointsRoute1,
      colorParam: Colors.red,
    );
    _polylineR2 = _polylineR2.copyWith(
      pointsParam: polylinePointsRoute2,
      colorParam: Colors.green,
    );
  }

  void signOutUser() {
    AuthService().signOut(context);
  }

  // Permission
  Future<LocationPermission> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  // ดึง Location ของ User
  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  //คำนวณระยะทางระหว่าง Location ของ User กับ Markers
  double _calculateDistance(LatLng markerLatLng) {
    return Geolocator.distanceBetween(_userLocation.latitude,
        _userLocation.longitude, markerLatLng.latitude, markerLatLng.longitude);
  }

  //หา Marker ที่อยู่ใกล้ Location ของ User มากที่สุด
  Marker closestMarker = const Marker(
    markerId: MarkerId('default'),
    position: LatLng(0, 0), // Set default coordinates
  );

  Marker _findClosestMarker() {
    double closestDistance = double.infinity;
    for (Marker marker in _markers) {
      double distance = _calculateDistance(marker.position);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestMarker = marker;
      }
    }
    return closestMarker;
  }

  // set activity ไป database ======================================================================================================
  setAllActivity() {
    DateTime now = DateTime.now();
    var user = Provider.of<UserProvider>(context, listen: false);
    // const std_id = '123';
    final setActivity = context.read<actiivity_provider>();
    setActivity.set_studentId_act(user.user.studentid);
    setActivity.set_marker_act('${closestMarker.infoWindow.title}');
    setActivity.set_location_act("${closestMarker.position}");
    setActivity.set_date_act("${now.year}/${now.month}/${now.day}");
    setActivity.set_time_act("${now}");
  }
//  ====================================================================================================================================

// แสดงผล Marker ที่อยู่ใกล้ Location ของ User
  void _showClosestMarker() {
    _findClosestMarker();
    _getUserLocation();
    _getDistanceText();
    Marker closestMarker = _findClosestMarker();
    print(closestMarker);
    // แสดงผล Marker ที่อยู่ใกล้ Location ของ User
    // ...
  }

  // คำนวณระยะทางระหว่าง Location ของ User กับ Marker ที่อยู่ใกล้ที่สุด
  String _getDistanceText() {
    double distance = _calculateDistance(_findClosestMarker().position);
    // แปลงค่าระยะทางเป็น String
    String distanceText =
        'คุณห่างจากป้าย ${closestMarker.infoWindow.title} ${distance.toStringAsFixed(0)} ม.';
    return distanceText;
  }

  //คำนวนเวลา
  String _getTimeText() {
    //คำนวนเวลาที่จะถึงป้ายที่ใกล้ที่สุด
    closestMarker = _findClosestMarker();
    double distanceTime = _calculateDistance(closestMarker.position);
    double speed = 40.0; // กม./ชม. (ค่าประมาณ)
    double time = distanceTime / speed;
    String distanceTimeText = 'จะถึงป้ายในอีก ${time.toStringAsFixed(2)} นาที.';
    return distanceTimeText;
  }

  @override
  Widget build(BuildContext context) {
    final getActivity = context.watch<actiivity_provider>();
    // String selectedRoute = Provider.of<ChangeRoute>(context).route;
    Size size = MediaQuery.of(context).size;

    var busline_provider_get = context.watch<Busline_provider>();
    var busline_provider_set = context.read<Busline_provider>();
    var itemsActionBar = [
      FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          setState(() {
            selectedRoute = "route1";
            print(selectedRoute);
            _showClosestMarker();
            setAllActivity();
            // get current user information
            var user = Provider.of<UserProvider>(context, listen: false);
            print('StudentID: ' + user.user.studentid);
            Provider.of<actiivity_provider>(context, listen: false)
                .createActivity(
              {
                "studentid": getActivity.get_studentId_act(),
                "location": getActivity.get_location_act(),
                "marker": getActivity.get_marker_act(),
                "data": getActivity.get_date_act(),
                "time": getActivity.get_time_act(),
                "route": selectedRoute
              },
            );
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(MdiIcons.numeric1,color:  Theme.of(context).primaryColorLight),
      ),
      FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          setState(() {
            selectedRoute = "route2";
            print(selectedRoute);
            _showClosestMarker();
            setAllActivity();
            // get current user information
            var user = Provider.of<UserProvider>(context, listen: false);
            print('StudentID: ' + user.user.studentid);
            Provider.of<actiivity_provider>(context, listen: false)
                .createActivity(
              {
                "studentid": getActivity.get_studentId_act(),
                "location": getActivity.get_location_act(),
                "marker": getActivity.get_marker_act(),
                "data": getActivity.get_date_act(),
                "time": getActivity.get_time_act(),
                "route": selectedRoute
              },
            );
          });
        },
        backgroundColor: Theme.of(context).primaryColorLight,
        child: Icon(MdiIcons.numeric2 ,color: Theme.of(context).primaryColor,),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 75,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        automaticallyImplyLeading: false,
        leading: IconButton(
            color:  Theme.of(context).primaryColorLight,
            onPressed: () {
              signOutUser();
            },
            icon: const Icon(Icons.logout_rounded)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Map'),
            Row(
              children: [
                if (selectedRoute == "route2")
                  const Text("Route 2 Hospital")
                else
                  const Text("Route 1 C5"),
              ],
            )
          ],
        ),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: _markers.toSet(),
            polylines: {selectedRoute == "route2" ? _polylineR2 : selectedRoute == "route1" ? _polylineR1 :_polylineR0 },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
        // // แสดงปุ่มสำหรับค้นหา Marker ที่อยู่ใกล้ Location ของ User
        // Positioned(
        //     bottom: 20,
        //     left: 20,
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         _showClosestMarker();
        //         setAllActivity();
        //         // get current user information
        //         var user = Provider.of<UserProvider>(context, listen: false);
        //         print('StudentID: ' + user.user.studentid);
        //         Provider.of<actiivity_provider>(context, listen: false)
        //             .createActivity(
        //           {
        //             "studentid": getActivity.get_studentId_act(),
        //             "location": getActivity.get_location_act(),
        //             "marker": getActivity.get_marker_act(),
        //             "data": getActivity.get_date_act(),
        //             "time": getActivity.get_time_act(),
        //             "route": selectedRoute
        //           },
        //         );
        //       },
        //       child: const Icon(Icons.search),
        //     )),
        // แสดง TextOverlay สำหรับแสดงระยะทาง
        Positioned(
          top: 20,
          left: 20,
          child: SizedBox(
            width: 250,
            height: 30,
            child: Text(
              // แสดงค่าระยะทาง
              _getDistanceText(),
            ),
          ),
        ),
        Positioned(
          top: 39,
          left: 20,
          child: SizedBox(
            width: 250,
            height: 30,
            child: Text(
              // แสดงค่าเวลา
              _getTimeText(),
            ),
          ),
        ),
      ]),
      floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
              key: busline_provider_get.get_fabKey(),
              alignment: Alignment.bottomCenter,
              ringColor: Theme.of(context).primaryColorLight,
              ringDiameter: 200,
              ringWidth: 0,
              fabSize: 50.0,
              fabElevation: 8.0,
              fabColor: Theme.of(context).primaryColor,
              fabOpenIcon: Icon(Icons.navigation_rounded,
                  color: Theme.of(context).primaryColorLight),
              fabCloseIcon:
                  Icon(Icons.close, color: Theme.of(context).primaryColorLight),
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
              children: itemsActionBar)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
