import 'package:flutter/material.dart';
import 'package:final_pj/pages/map/widgets/widgets.dart';

class Mappage extends StatelessWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Container(),
      floatingActionButton: Builder(builder: (context)=>Buslinebutton()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
