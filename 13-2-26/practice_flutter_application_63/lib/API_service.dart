import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_63/models/B_filter_models_2.dart';

class ApiService {
  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  // A
  Future<dynamic> uploadImageAPI(Uint8List bytes, String fileName) async {
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.escuelajs.co/api/v1/files/upload"),
    );

    http.MultipartFile multipartFile = http.MultipartFile(
      'file',
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: fileName,
    );

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final data = await response.stream.bytesToString();
      return jsonDecode(data);
    }
    return null;
  }

  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////

  // B
  Future<FilterModel?> filterAPI() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/users"),
    );

    if (response.statusCode == 200) {
      return FilterModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
