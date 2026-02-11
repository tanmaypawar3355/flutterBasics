import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practie_flutter_application_61/models/A_get_single_object_with_model.dart';
import 'package:practie_flutter_application_61/models/C_get_multiple_object_with_model.dart';

class ApiService {
  //////////////////////////////////////////////////////////////////////

  // Single object with model - A
  Future<GetSingleObjectWithModel?> singleObjectWithModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      GetSingleObjectWithModel model = GetSingleObjectWithModel.fromJson(
        json.decode(response.body),
      );
      return model;
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////
  // Single object with model - B
  Future<dynamic> singleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    }

    return null;
  }

  //////////////////////////////////////////////////////////////////////

  // Miltiple object with model - C
  Future<List<GetMultipleObjectWithModel>?> multipleObjectWithModel() async {
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
    print("returning null");
    return null;
  }

  //////////////////////////////////////////////////////////////////////

  // Miltiple object with model - C
  Future<dynamic> multipleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return data;
    }
    print("returning null");
    return null;
  }

  //////////////////////////////////////////////////////////////////////
}
