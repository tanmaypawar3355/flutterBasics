import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_66/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_66/models/C_multiple_object_model_3.dart';
import 'package:practice_flutter_application_66/models/G_filter_model_7.dart';

class ApiService {
  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // A
  Future<SingleObjectModel?> getSingleObjectWithModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      return SingleObjectModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // B
  Future<dynamic> getSingleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // C
  Future<List<MultipleObjectModel>?> getMultipleObjectWithModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      List<MultipleObjectModel> list = List<MultipleObjectModel>.from(
        jsonDecode(response.body).map((i) => MultipleObjectModel.fromJson(i)),
      );

      return list;
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // D
  Future<dynamic> getMultipleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // E
  Future<String?> postAPI(String email, String password) async {
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

  Future<dynamic> getAPI(String accessToken) async {
    http.Response response = await http.get(
      Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  // F
  Future<dynamic> uploadImageAPI(Uint8List bytes, String fileName) async {
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
      final data = jsonDecode(await response.stream.bytesToString());
      return data;
    } else {
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////
  
  // G
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
