import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_flutter_application_49/user_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<UserModel>?> getUsers() async {
    // Tells the server:
    // “I’m sending / expecting JSON data”
    Map<String, String> requestHeaders = {'Content-Type': "application/json"};

    // Builds a secure (HTTPS) URL
    // Equivalent to:
    // https://fakestoreapi.com/carts
    var url = Uri.https("fakestoreapi.com", "/carts");

    // Sends a GET request
    // await waits for the response
    // Stores response in response
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((e) => UserModel.fromJson(e)).toList();
    } else {
      print("hiiiiiiiiiiiii");
      return null;
    }
  }
}

/*

| Range       | Meaning                         |
| ----------- | -----------------------------   |
| **100–199** | Informational                   |
| **200–299** | ✅ Success                     |
| **300–399** | Redirect                        |
| **400–499** | ❌ Client Error (your mistake) |
| **500–599** | 💥 Server Error                |

*/
