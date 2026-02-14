import 'package:flutter/material.dart';
import 'package:practice_flutter_application_64/models/G_filter_model_7.dart';
import 'package:practice_flutter_application_64/API_service.dart';

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class _HomePage7State extends State<HomePage7> {
  dynamic data;

  FilterModel model = FilterModel();

  void filterAPI() async {
    ApiService().filterAPI().then((value) {
      setState(() {
        model = value;
        maleFilter(model.users!);
        femaleFilter(model.users!);
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    filterAPI();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("F I L T E R   A P I"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(child: Text("M A L E")),
              Tab(child: Text("F E M A L E")),
            ],
          ),
        ),
        body: TabBarView(children: [maleUsers(), femaleUsers()]),
      ),
    );
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

  Widget maleUsers() {
    return ListView.builder(
      itemCount: maleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(child: Text(index.toString())),
            title: Text(maleList[index].firstName.toString()),
            subtitle: Text(maleList[index].bloodGroup.toString()),
          ),
        );
      },
    );
  }

  Widget femaleUsers() {
    return ListView.builder(
      itemCount: femaleList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text(femaleList[index].firstName.toString()),
          subtitle: Text(femaleList[index].bloodGroup.toString()),
        );
      },
    );
  }
}
