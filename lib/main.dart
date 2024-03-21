import 'package:final_pj/Map.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
// import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:final_pj/pages/home/view/homepage.dart';
void main() {
  runApp(const MyApp());
}

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
      home: const MapSample(),
    );
  }
}

