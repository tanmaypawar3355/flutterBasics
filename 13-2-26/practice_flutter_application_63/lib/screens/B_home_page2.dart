import 'package:flutter/material.dart';
import 'package:practice_flutter_application_63/API_service.dart';
import 'package:practice_flutter_application_63/models/B_filter_models_2.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  FilterModel model = FilterModel();

  void _filterAPI() async {
    ApiService().filterAPI().then((value) {
      model = value!;
      _maleFilter(model.users!);
      _femaleFilter(model.users!);
      setState(() {});
    });
  }

  @override
  void initState() {
    _filterAPI();
    super.initState();
  }

  List<Users> maleList = [];
  void _maleFilter(List<Users> list) {
    for (var element in list) {
      if (element.gender == "male") {
        maleList.add(element);
      }
    }
  }

  List<Users> femaleList = [];
  void _femaleFilter(List<Users> list) {
    for (var element in list) {
      if (element.gender == "female") {
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
          backgroundColor: Colors.deepPurple,
          title: Text(
            "F I L T E R ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            tabs: [
              Tab(
                child: Text(
                  "M A L E",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "F E M A L E",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [_maleUsers(), _femaleUsers()]),
      ),
    );
  }

  Widget _maleUsers() {
    return ListView.builder(
      itemCount: maleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text(maleList[index].firstName.toString()),
            subtitle: Text(femaleList[index].address!.city.toString()),
          ),
        );
      },
    );
  }

  Widget _femaleUsers() {
    return ListView.builder(
      itemCount: femaleList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text(femaleList[index].firstName.toString()),
            subtitle: Text(femaleList[index].address!.city.toString()),
          ),
        );
      },
    );
  }
}
