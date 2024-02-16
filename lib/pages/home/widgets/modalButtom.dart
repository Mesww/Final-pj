import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final nameController = TextEditingController();
final desController = TextEditingController();

addDataWidget(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          width: 400,
          child: Column(children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Add name"),
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(hintText: "Add descripttion"),
            ),
            ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    Provider.of<usersProvider>(context, listen: false).addData({
                      "title": nameController.text,
                      "description": desController.text
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Submit"))
          ]),
        );
      });
}

updateDataWidget(BuildContext context, String _id) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          width: 400,
          child: Column(children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Update name"),
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(hintText: "Update description"),
            ),
            ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    Provider.of<usersProvider>(context, listen: false)
                        .updateData({
                      "_id": _id,
                      "title": nameController.text,
                      "description": desController.text
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Update"))
          ]),
        );
      });
}


