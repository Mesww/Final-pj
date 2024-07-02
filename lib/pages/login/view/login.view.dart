import 'dart:io';

import 'package:final_pj/pages/register/view/view.dart';
import 'package:final_pj/provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import '../../map/view/view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getFormLogin = context.watch<Form_login>();
    final setFormLogin = context.read<Form_login>();
    final obscure_password = getFormLogin.get_obscure_password();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
            key: getFormLogin.get_formkey(),
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
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // !submit button
                  GestureDetector(
                    onTap: () async {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: ((context) => Mappage())));
                      // if (getFormLogin.get_formkey().currentState!.validate()) {
                      //   getFormLogin.get_formkey().currentState!.save();
                      //   setFormLogin.loginUser(context);
                      // }
                      //Default definition
                      GoogleSignIn googleSignIn = GoogleSignIn(
                        scopes: [
                          'email',
                        ],
                      );

//If current device is Web or Android, do not use any parameters except from scopes.
                      if (kIsWeb || Platform.isAndroid) {
                        googleSignIn = GoogleSignIn(
                          scopes: [
                            'email',
                          ],
                        );
                      }

                      if (Platform.isIOS || Platform.isMacOS) {
                        googleSignIn = GoogleSignIn(
                          clientId: "977400494676-r4ihi082v8uce61t9q3ofuuaia5pjare.apps.googleusercontent.com",
                          scopes: [
                            'email',
                          ],
                        );
                      }

                      final GoogleSignInAccount? googleAccount =
                          await googleSignIn.signIn();

                      //further information about Google accounts, such as authentication, use this.
                      final GoogleSignInAuthentication googleAuthentication =
                          await googleAccount!.authentication;
                      // print(googleAuthentication.accessToken);
                      
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/googlelogo.png",width: 20,),
                            SizedBox(width: 10,),
                            Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
