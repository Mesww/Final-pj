import 'package:final_pj/pages/loading/loading.dart';
import 'package:final_pj/pages/login/login.dart';
import 'package:final_pj/provider/busLocation.dart';
import 'package:final_pj/provider/user.provider.dart';
// import 'package:final_pj/provider/changeRoute.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/config/pallete.dart';
import 'pages/map/map.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:provider/provider.dart';
import './services/auth.service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Busline_provider()),
      ChangeNotifierProvider(create: (_) => usersProvider()),
      ChangeNotifierProvider(create: (_) => ChangeRoute()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => actiivity_provider()),
      ChangeNotifierProvider(create: (_) => busLocation()),
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
  bool isProgressing = false;
  bool isLoggedIn = false;
  @override
  void initState() {
    initAuth();
    super.initState();
  }

  initAuth() async {
    setLoadingState();
    final bool isAuthenticated = await AuthService.instance.initAuth();
    if (isAuthenticated) {
      setAuthenticatedState();
    } else {
      setUnauthenticatedState();
    }
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
    });
  }

  setAuthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });
  }

  setUnauthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Palette.redwood,
        primaryColorLight: Palette.goldmfu,
        useMaterial3: true,
      ),
      home: SafeArea(child: Builder(builder: (context){
        if (isProgressing) {
              return const LoadingScreen();
            } else if (isLoggedIn) {
              return Mappage(
                setUnauthenticatedState: setUnauthenticatedState,
              );
            } else {
              return LoginView(
                setLoadingState: setLoadingState,
                setAuthenticatedState: setAuthenticatedState,
                setUnauthenticatedState: setUnauthenticatedState,
              );
            }
      }),)
    );
  }
}
