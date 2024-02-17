import 'package:final_pj/pages/map/view/mappage.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>Busline_provider()),
      ChangeNotifierProvider(create: (_) => usersProvider()),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

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
      home: Mappage(),
    );
}
}

