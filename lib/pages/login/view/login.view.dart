import 'dart:io';

import 'package:final_pj/provider/provider.dart';
import 'package:final_pj/utils/contrants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/auth.service.dart';
import '../../map/view/view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late SharedPreferences prefs;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ! Text
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Image.asset(
                      'assets/Mae-Fah-Luang-University-2-768x779.png',
                      width: 100,
                    )),
                Text(
                  'HELLO',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Welcome to MFU GEMS CAR',
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight, fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                // !submit button
                GestureDetector(
                  onTap: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
                    // googleSignIn = GoogleSignIn(
                    //   scopes: ['email'],
                    //   clientId: kIsWeb || Platform.isAndroid
                    //       ? null
                    //       : Platform.isIOS || Platform.isMacOS
                    //           ? Constants.iosgoogleclientid
                    //           : null,
                    // );

                    if (Platform.isIOS || Platform.isMacOS) {
                      googleSignIn = GoogleSignIn(scopes: ['email'],clientId: Constants.iosgoogleclientid,serverClientId: Constants.servergoogleclientid);
                    }

                    if ( kIsWeb || Platform.isAndroid) {
                       googleSignIn = GoogleSignIn(scopes: ['email'],clientId: Constants.androidgoogleclientid,serverClientId: Constants.servergoogleclientid);
                    }


                    AuthService auth = AuthService();
                    auth.handleSignIn(googleSignIn, context, prefs);

                    prefs.getString('token');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/googlelogo.png",
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
