import 'package:final_pj/pages/home/widgets/modalButtom.dart';
import 'package:final_pj/provider/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void refreshData() async {
    try {
      await Provider.of<usersProvider>(context, listen: false).fetchData();
      setState(() {}); // Force the widget to rebuild and update data
    } catch (error) {
      // Handle error appropriately (e.g., show a snackbar)
    }
  }

  @override
  void initState() {
    Provider.of<usersProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDataWidget(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Homepage'),
        actions: [
          IconButton(onPressed: refreshData, icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        child: Consumer<usersProvider>(
          builder: (context, model, _) => FutureBuilder(
            future: model.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Or any other loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: model.usersData.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            refreshData();
                            model.deleteData(model.usersData[index]['_id']);
                          },
                          icon: Icon(Icons.delete)),
                      onTap: () {
                        updateDataWidget(
                            context, model.usersData[index]['_id']);
                      },
                      title: Text(model.usersData[index]['title']),
                      subtitle: Text(model.usersData[index]['description']),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
