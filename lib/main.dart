import 'package:final_pj/pages/login/login.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:final_pj/pages/home/view/homepage.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>Busline_provider()),
      ChangeNotifierProvider(create: (context)=>Form_login()),
      ChangeNotifierProvider(create: (_) => usersProvider()),
      ChangeNotifierProvider(create: (_) => Register_provider()),
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
        primaryColorLight: Palette.goldmfu,
        useMaterial3: true,
      ),
      home: const LoginView(),
    );
}
}
