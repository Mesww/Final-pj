import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:final_pj/pages/map/widgets/const.dart';
import 'package:final_pj/pages/map/widgets/fab_circular_menu.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart';
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
  late SharedPreferences prefs;
  late Map<String, dynamic> decodedToken;

  final directionsApi = DirectionsService();
  late LatLng selectedMarker;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.050236851378024, 99.89456487892942),
    zoom: 16,
  );
  late GoogleMapController _controller;
  StreamSubscription<Position>? _positionStream;
  String selectedRoute = "";
  bool _isShow = true;

  final double _proximityThreshold = 5;

  // กำหนด State สำหรับ Location ของ User
  late LatLng _userLocation =
      const LatLng(20.050236851378024, 99.89456487892942);

// Route 1
  Polyline _polylineR1 = const Polyline(polylineId: PolylineId("polylineR1"));
  // Route 2
  Polyline _polylineR2 = const Polyline(polylineId: PolylineId("polylineR2"));

  Polyline _polylineR0 = const Polyline(polylineId: PolylineId("polylineR0"));

  BitmapDescriptor customMarkerIcon = BitmapDescriptor.defaultMarker;

  void _loadcustomMarkerIcon() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/directions_bus.png', // Provide the path to your custom marker image
    );
  }

  @override
  void initState() {
    super.initState();
    // _markers.addAll(list);
    _setPolylinePoints();
    _requestLocationPermission();
    _getUserLocation();
    _loadcustomMarkerIcon();

    // set share token
    initSharedPref();

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

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    // set decode token
    decodedToken = prefs.getString("token") != null
        ? AuthService().decodeJWT(prefs.getString("token")!)
        : {};
    print(decodedToken);
  }

  //ลากเส้นทาง
  void _setPolylinePoints() {
    //Import form const.dart
    _polylineR1 = _polylineR1.copyWith(
      pointsParam: polylinePointsRoute1,
      colorParam: const Color(0xffA23E48),
    );
    _polylineR2 = _polylineR2.copyWith(
      pointsParam: polylinePointsRoute2,
      colorParam: const Color(0xffbc9945),
    );
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

  Marker _findClosestMarker(_markers) {
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
    // var user = Provider.of<UserProvider>(context, listen: false);
    // const std_id = '123';
    final setActivity = context.read<actiivity_provider>();
    setActivity.set_studentId_act(decodedToken['id']);
    setActivity.set_marker_act('${closestMarker.infoWindow.title}');
    setActivity.set_location_act("${closestMarker.position}");
    setActivity.set_date_act("${now.year}/${now.month}/${now.day}");
    setActivity.set_time_act("${now}");
  }
//  ====================================================================================================================================

// แสดงผล Marker ที่อยู่ใกล้ Location ของ User
  void _showClosestMarker(_markers) {
    _findClosestMarker(_markers);
    _getUserLocation();
    _getDistanceText(_markers);
    Marker closestMarker = _findClosestMarker(_markers);
    print(closestMarker);
    // แสดงผล Marker ที่อยู่ใกล้ Location ของ User
    // ...
  }

  // คำนวณระยะทางระหว่าง Location ของ User กับ Marker ที่อยู่ใกล้ที่สุด
  String _getDistanceText(_markers) {
    double distance = _calculateDistance(_findClosestMarker(_markers).position);
    // แปลงค่าระยะทางเป็น String
    String distanceText =
        'คุณห่างจากป้าย ${closestMarker.infoWindow.title} ${distance.toStringAsFixed(0)} ม.';
    return distanceText;
  }

  //คำนวนเวลา
  String _getTimeText(_markers) {
    //คำนวนเวลาที่จะถึงป้ายที่ใกล้ที่สุด
    closestMarker = _findClosestMarker(_markers);
    double distanceTime = _calculateDistance(closestMarker.position);
    double speed = 40.0; // กม./ชม. (ค่าประมาณ)
    double time = distanceTime / speed;
    String distanceTimeText = 'จะถึงป้ายในอีก ${time.toStringAsFixed(2)} นาที.';
    return distanceTimeText;
  }

  // เซ็ต camera ไปที่ location ของ user
  void _goToMyLocation() async {
    _getUserLocation();
    // Animate camera to user's location
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_userLocation.latitude, _userLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  void _zoomIn() {
    _controller.animateCamera(
        CameraUpdate.zoomTo(_kGooglePlex.zoom + 1)); // Increase zoom by 1
  }

  void _zoomOut() {
    _controller.animateCamera(
        CameraUpdate.zoomTo(_kGooglePlex.zoom - 1)); // Decrease zoom by 1
  }

  void _zoomInMaker(LatLng position) {
    print(position);
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 17.0,
      ),
    )); // Increase zoom by 1
  }

  late List mark;
  @override
  Widget build(BuildContext context) {
    // ! ต้องเอาmarkersไว้ใน build ในการทำ custom icon
    List<Marker> _markers = [
      Marker(
          markerId: const MarkerId('1'),
          position: const LatLng(20.05884362541219, 99.89840388818074),
          infoWindow: const InfoWindow(title: '1'),
          icon: customMarkerIcon,
          onTap: () {
            selectedMarker = LatLng(20.05884362541219, 99.89840388818074);
            _zoomInMaker(selectedMarker);
          }),
      Marker(
          markerId: const MarkerId('2'),
          position: const LatLng(20.05709734818155, 99.89694381071735),
          infoWindow: const InfoWindow(title: '2'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('3'),
          position: const LatLng(20.054714358618483, 99.89456736656254),
          infoWindow: const InfoWindow(title: '3'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('4'),
          position: const LatLng(20.052565215511244, 99.89231798713149),
          infoWindow: const InfoWindow(title: '4'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('5'),
          position: const LatLng(20.050816843021277, 99.89121969349162),
          infoWindow: const InfoWindow(title: '5'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('6'),
          position: const LatLng(20.049137353450433, 99.891250485570452),
          infoWindow: const InfoWindow(title: '6'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('7'),
          position: const LatLng(20.048397671997282, 99.89320068812843),
          infoWindow: const InfoWindow(title: '7'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('8'),
          position: const LatLng(20.047264832318994, 99.89314563095694),
          infoWindow: const InfoWindow(title: '8'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('9'),
          position: const LatLng(20.045737111535473, 99.89152205304603),
          infoWindow: const InfoWindow(title: '9'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('10'),
          position: const LatLng(20.043881444753783, 99.89348617576454),
          infoWindow: const InfoWindow(title: '10'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('11'),
          position: const LatLng(20.043919609786567, 99.89490923095694),
          infoWindow: const InfoWindow(title: '11'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('12'),
          position: const LatLng(20.043311336533844, 99.89529707515575),
          infoWindow: const InfoWindow(title: '12'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('13'),
          position: const LatLng(20.043845538331563, 99.8934754469289),
          infoWindow: const InfoWindow(title: '13'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('14'),
          position: const LatLng(20.045659393241642, 99.89133178188165),
          infoWindow: const InfoWindow(title: '14'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('15'),
          position: const LatLng(20.049391118491396, 99.89111283095696),
          infoWindow: const InfoWindow(title: '15'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('16'),
          position: const LatLng(20.05083048583872, 99.89115650886787),
          infoWindow: const InfoWindow(title: '16'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('17'),
          position: const LatLng(20.052689636083315, 99.89234180090831),
          infoWindow: const InfoWindow(title: '17'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('18'),
          position: const LatLng(20.05473222049373, 99.89448019896511),
          infoWindow: const InfoWindow(title: '18'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('19'),
          position: const LatLng(20.056897650552507, 99.89711855304603),
          infoWindow: const InfoWindow(title: '19'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('20'),
          position: const LatLng(20.05806378447924, 99.89787541746388),
          infoWindow: const InfoWindow(title: '20'),
          icon: customMarkerIcon),
      Marker(
          markerId: const MarkerId('21'),
          position: const LatLng(20.058966957817436, 99.8995173298247),
          infoWindow: const InfoWindow(title: '21'),
          icon: customMarkerIcon),
    ];

    void MarkerLoop() {
      for (var i = 0; i < 20; i++) {
        if (_markers[i].position == selectedMarker) {
          print(
              "================================================================");
          print(_markers[i]);
          print(selectedMarker);
          print(
              "================================================================");
        }
      }
    }

    // _marker[0].icon = customMarkerIcon;
    final getActivity = context.watch<actiivity_provider>();
    // String selectedRoute = Provider.of<ChangeRoute>(context).route;
    var busline_provider_get = context.watch<Busline_provider>();
    var busline_provider_set = context.read<Busline_provider>();
    var itemsActionBar = [
      FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            selectedRoute = "route1";
            MarkerLoop();
            _showClosestMarker(_markers);
            setAllActivity();
            // get current user information
            // var user = Provider.of<UserProvider>(context, listen: false);
            // print('StudentID: ' + user.user.studentid);
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
        child:
            Icon(MdiIcons.numeric1, color: Theme.of(context).primaryColorLight),
      ),
      FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            selectedRoute = "route2";
            print(selectedRoute);
            _showClosestMarker(_markers);
            setAllActivity();
            // get current user information
            // var user = Provider.of<UserProvider>(context, listen: false);
            // print('StudentID: ' + user.user.studentid);

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
        child: Icon(
          MdiIcons.numeric2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        automaticallyImplyLeading: false,
        leading: IconButton(
            color: Theme.of(context).primaryColorLight,
            onPressed: () {
              AuthService().handleSignOut(context, prefs);
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
                else if (selectedRoute == "route1")
                  const Text("Route 1 C5")
                else
                  const Text(""),
              ],
            )
          ],
        ),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: _markers.toSet(),
          polylines: {
            selectedRoute == "route2"
                ? _polylineR2
                : selectedRoute == "route1"
                    ? _polylineR1
                    : _polylineR0
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
        Positioned(
            top: 90,
            left: 8,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _isShow = !_isShow;
                  });
                },
                icon: Icon(Icons.navigate_next_outlined))),
        Positioned(
          top: 100,
          left: 20,
          child: Visibility(
              visible: _isShow,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                width: 300,
                height: 80,
                color: Colors.amber,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(_getDistanceText(_markers)),
                              Text(_getTimeText(_markers))
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _isShow = !_isShow;
                              });
                            },
                            icon: Icon(Icons.navigate_before_rounded))
                      ],
                    ),
                  ],
                ),
              )),
        ),
        Positioned(
          top: 100.0,
          right: 20.0,
          child: Column(
            children: [
              GestureDetector(
                onTap: _goToMyLocation,
                child: Icon(
                  MdiIcons.compass,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              GestureDetector(
                onTap: _zoomIn,
                child: Icon(
                  MdiIcons.plusCircle,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              GestureDetector(
                onTap: _zoomOut,
                child: Icon(
                  MdiIcons.minusCircle,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
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
