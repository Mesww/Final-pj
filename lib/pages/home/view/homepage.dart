import 'package:flutter/material.dart';
import 'package:final_pj/pages/home/widgets/widgets.dart';
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Test(),
    );
  }
}
