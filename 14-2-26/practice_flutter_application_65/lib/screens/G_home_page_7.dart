import 'package:flutter/material.dart';
import 'package:practice_flutter_application_65/API_service.dart';
import 'package:practice_flutter_application_65/models/G_filter_model_7.dart';

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class _HomePage7State extends State<HomePage7> {
  FilterModel model = FilterModel();
  void getData() {
    ApiService().FilterAPI().then((value) {
      setState(() {
        model = value!;
        maleFilter(model.users!);
        femaleFilter(model.users!);
      });
    });
  }

  List<Users> maleList = [];
  void maleFilter(List<Users> list) {
    for (var i in list) {
      if (i.gender == "male") {
        maleList.add(i);
      }
    }
  }

  List<Users> femaleList = [];

  void femaleFilter(List<Users> list) {
    for (var i in list) {
      if (i.gender == "female") {
        femaleList.add(i);
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("F I L T E R       A P I"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: const Color.fromARGB(255, 222, 7, 7),

            tabs: [
              Tab(child: Text("               M A L E               ")),
              Tab(
                child: Text(
                  "                   F E M A L E                    ",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [maleUsers(), femaleUsers()]),
      ),
    );
  }

  Widget maleUsers() {
    return ListView.builder(
      itemCount: maleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: const Color.fromARGB(255, 136, 229, 235),
            child: ListTile(
              leading: CircleAvatar(child: Text("${index + 1}".toString())),
              title: Text(maleList[index].firstName.toString()),
              subtitle: Text(maleList[index].email.toString()),
            ),
          ),
        );
      },
    );
  }

  Widget femaleUsers() {
    return ListView.builder(
      itemCount: femaleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.grey[400],
            child: ListTile(
              leading: CircleAvatar(child: Text("${index + 1}".toString())),
              title: Text(femaleList[index].firstName.toString()),
              subtitle: Text(femaleList[index].email.toString()),
            ),
          ),
        );
      },
    );
  }
}
