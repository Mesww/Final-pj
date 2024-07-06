import 'dart:convert';

import 'package:final_pj/pages/login/login.dart';
import 'package:final_pj/pages/map/map.dart';
import 'package:final_pj/utils/contrants.dart';
import 'package:final_pj/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> handleSignIn(GoogleSignIn googleSignIn, BuildContext context,
      SharedPreferences prefs) async {
    final navigator = Navigator.of(context);

    // var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        final response = await http.post(
          Uri.parse('${Constants.uri}/users/signin'),
          body: {'idToken': auth.idToken},
        );

        if (response.statusCode == 200) {
          // Successfully verified token
          print('Token verified: ${response.body}');
          prefs.setString('token', response.body);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Mappage()),
              (route) => false);
        } else {
          print('Token verification failed');
        }
      }
    } catch (error) {
      showSnackBar(context, error.toString());
      print(error);
    }
  }

  Map<String, dynamic> decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  void handleSignOut(BuildContext context, SharedPreferences prefs) async {
    final navigator = Navigator.of(context);
    // var userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.clearUser();
    prefs.clear();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
      (route) => false,
    );
  }
}
