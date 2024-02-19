import 'dart:async';
import 'package:final_pj/pages/map/mapPage.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'pages/home/home.dart';

Future<void> main() async {
  runApp(const MyApp());
}

// Future<void> getLocation() async {
//   Location location = new Location();
//   var _locationData = await location.getLocation();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MapPage(),
    );
  }
}
