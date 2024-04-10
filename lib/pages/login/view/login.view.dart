import 'package:final_pj/provider/provider.dart';
import 'package:final_pj/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import '../../map/view/view.dart';

class LoginView extends StatelessWidget {
  const LoginView(
      {Key? key,
      required this.setLoadingState,
      required this.setAuthenticatedState,
      required this.setUnauthenticatedState})
      : super(key: key);
  final VoidCallback setLoadingState;
  final VoidCallback setAuthenticatedState;
  final VoidCallback setUnauthenticatedState;

 Future<void> loginAction() async {
   setLoadingState();
    final authSuccess = await AuthService.instance.login();
    if (authSuccess) {
      setAuthenticatedState();
    } else {
      setUnauthenticatedState();
    }
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
                  onTap: loginAction,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
