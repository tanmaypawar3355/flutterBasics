import 'package:flutter/material.dart';
import 'package:practice_flutter_application_66/API_service.dart';
import 'package:practice_flutter_application_66/models/G_filter_model_7.dart';

class HomePage7 extends StatefulWidget {
  const HomePage7({super.key});

  @override
  State<HomePage7> createState() => _HomePage7State();
}

class _HomePage7State extends State<HomePage7> {
  FilterModel model = FilterModel();
  void getData() async {
    await ApiService()
        .FilterAPI()
        .then((value) {
          setState(() {
            model = value!;
            maleFilter(model.users!);
            femaleFilter(model.users!);
          });
        })
        .onError((error, stackTrace) {
          print(error.toString());
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Users> maleList = [];
  void maleFilter(List<Users> list) {
    for (var element in list) {
      if (element.gender == 'male') {
        maleList.add(element);
      }
    }
  }

  List<Users> femaleList = [];
  void femaleFilter(List<Users> list) {
    for (var element in list) {
      if (element.gender == 'female') {
        femaleList.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" F I L T E R        A P I"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("M A L E")),
              Tab(child: Text("F E M A L E")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: maleList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(index.toString())),
                    title: Text(maleList[index].firstName.toString()),
                    subtitle: Text(maleList[index].age.toString()),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: femaleList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(index.toString())),
                    title: Text(femaleList[index].firstName.toString()),
                    subtitle: Text(femaleList[index].age.toString()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
