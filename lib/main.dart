import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'pages/home/home.dart';
import 'pages/map/map.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Palette.redwood,
        primaryColorLight: Palette.vermilion,
        primaryColorDark: Palette.bluegray,
        useMaterial3: true,
        
      ),
      home: const Mappage(),
    );
  }
}

