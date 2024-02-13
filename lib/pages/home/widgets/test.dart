import 'package:flutter/material.dart';
import 'package:final_pj/pages/login/login.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text('Test')),
    );
  }
}
