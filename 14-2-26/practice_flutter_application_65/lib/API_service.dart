import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_65/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_65/models/C_multiple_object_model_3.dart';
import 'package:practice_flutter_application_65/models/G_filter_model_7.dart';

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

  // B
  Future<dynamic> getSingleObjectWithoutModelAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  // C
  Future<List<GetMultipleObjectModel>?> getMultipleObjectWithModelAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      List<GetMultipleObjectModel> list = List<GetMultipleObjectModel>.from(
        jsonDecode(response.body).map((x) {
          return GetMultipleObjectModel.fromJson(x);
        }),
      );

      return list;
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  // D
  Future<dynamic> getMultipleObjectWithoutModelAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  // E
  Future<String?> postLoginAPI(String email, password) async {
    http.Response response = await http.post(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/login"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      return data['access_token'];
    }
    return null;
  }

  Future<dynamic> getLoginAPI(String accessToken) async {
    http.Response response = await http.get(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  // F
  Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    http.MultipartFile multipartFile = http.MultipartFile(
      "file",
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: fileName,
    );

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return jsonDecode(await response.stream.bytesToString());
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Future<FilterModel?> FilterAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/users"),
    );

    if (response.statusCode == 200) {
      return FilterModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
