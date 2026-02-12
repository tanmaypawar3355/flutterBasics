import 'package:flutter/material.dart';
import 'package:practice_flutter_application_62/API_service.dart';
import 'package:practice_flutter_application_62/models/A_get_single_object_with_model_1.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  GetSingleObjectWithModel? model = GetSingleObjectWithModel();
  bool _isReady = false;
  void _getSingleData() async {
    _isReady = false;
    APIService()
        .getSingleObjectWithModel()
        .then((value) {
          setState(() {
            model = value;
            _isReady = true;
          });
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }

  @override
  void initState() {
    _getSingleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isReady == false
          ? Center(child: CircularProgressIndicator())
          : Column(children: [
            Text(model!.id.toString()),
            Text(model!.userId.toString()),
            Text(model!.title.toString()),
            Text(model!.body.toString()),
        ],
      ),
    );
  }
}
