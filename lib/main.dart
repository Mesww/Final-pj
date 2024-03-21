<<<<<<< HEAD
import 'package:final_pj/Map.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
// import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:final_pj/pages/home/view/homepage.dart';
=======
import 'package:final_pj/pages/login/login.dart';
import 'package:final_pj/provider/user.provider.dart';
// import 'package:final_pj/provider/changeRoute.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';

>>>>>>> c2223a6703e1f8bba4d04338b89ef5bd006c00b5
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Busline_provider()),
      ChangeNotifierProvider(create: (context) => Form_login()),
      ChangeNotifierProvider(create: (_) => usersProvider()),
      ChangeNotifierProvider(create: (_) => Register_provider()),
      ChangeNotifierProvider(create: (_) => ChangeRoute()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => actiivity_provider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserProvider>(context).user.token.isEmpty);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Palette.redwood,
        primaryColorLight: Palette.goldmfu,
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const MapSample(),
=======
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const LoginView()
          : Mappage(),
>>>>>>> c2223a6703e1f8bba4d04338b89ef5bd006c00b5
    );
  }
}
