import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_62/models/A_get_single_object_with_model_1.dart';
import 'package:practice_flutter_application_62/models/C_get_multiple_object_with_model_3.dart';

class APIService {
  //  A
  Future<GetSingleObjectWithModel?> getSingleObjectWithModel() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
      );

      if (response.statusCode == 200) {
        GetSingleObjectWithModel model = GetSingleObjectWithModel.fromJson(
          jsonDecode(response.body),
        );
        return model;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

  //  B
  Future<dynamic> getSingleObjectWithoutModel() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

  //  C
  Future<List<GetMultipleObjectWithModel>?> getMultipleObjectWithModel() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );

      if (response.statusCode == 200) {
        List<GetMultipleObjectWithModel> list =
            List<GetMultipleObjectWithModel>.from(
              jsonDecode(
                response.body,
              ).map((x) => GetMultipleObjectWithModel.fromJson(x)),
            );

        return list;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

  //  D
  Future<dynamic> getMultipleObjectWithoutModel() async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

  // E
  Future<String?> postAPI(String email, password) async {
    http.Response response = await http.post(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/login"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      String accessToken = data['access_token'];
      return accessToken;
    }
    return null;
  }

  Future<dynamic> getAPI(String accessToken) async {
    http.Response response = await http.get(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    }
    print("bye");

    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////
}
