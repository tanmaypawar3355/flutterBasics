import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_64/models/A_single_object_model_1.dart';
import 'package:practice_flutter_application_64/models/C_multiple_object_model_3.dart';
import 'package:practice_flutter_application_64/models/G_filter_model_7.dart';

class ApiService {
  //  A
  Future<GetSingleObjectModel?> getSingleObjectWithModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      return GetSingleObjectModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  // B
  Future<dynamic> getSingleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body.toString());
      return data;
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  // C
  Future<List<GetMultipleObjectModel>?> getMultipleObjectWithModel() async {
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
    print("null");
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  // D
  Future<dynamic> getMultipleObjectWithoutModel() async {
    http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

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
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data;
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  // F
  Future<bool> uploadImageAPI(Uint8List bytes, String fileName) async {
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

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  ////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  // G

  Future<dynamic> filterAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/users"),
    );

    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      var data = FilterModel.fromJson(jsonDecode(response.body));
      return data;
    }
    return null;
  }
}
