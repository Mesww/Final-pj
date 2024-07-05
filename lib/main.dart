// import 'package:final_pj/Map.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
// import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:final_pj/pages/home/view/homepage.dart';
import 'package:final_pj/pages/login/login.dart';
// import 'package:final_pj/provider/changeRoute.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  share small data
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Busline_provider()),
      ChangeNotifierProvider(create: (_) => usersProvider()),
      ChangeNotifierProvider(create: (_) => ChangeRoute()),
      ChangeNotifierProvider(create: (_) => actiivity_provider()),
    ],
    child: MyApp(token: prefs.getString('token')),
  ));
}

class MyApp extends StatelessWidget {
  final token;
  
  const MyApp({
    super.key,
    @required this.token,
  });
  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = token != null;
    // bool isUserLoggedIn = false;
    print(isUserLoggedIn);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Palette.redwood,
        primaryColorLight: Palette.goldmfu,
        useMaterial3: true,
      ),
      home: isUserLoggedIn ? Mappage() : LoginView(),
    );
  }
}
