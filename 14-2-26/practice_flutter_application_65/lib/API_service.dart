import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_65/models/A_single_object_model_1.dart';

class ApiService {
  // A
  Future<SingleObjectModel?> getSingleObjectWithModelAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      return SingleObjectModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
}
