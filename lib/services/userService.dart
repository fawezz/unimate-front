
import 'dart:convert';

import 'package:univ_chat_gpt/app/Constants.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart';

class UserService{
  static const signInUrl = "user/signin";

  static Future<User> postLogin(String email, String pwd) async {
    Uri loginUri = Uri.parse(baseUrl + signInUrl);
    final data = {
      "email": email,
      "pwd": pwd
    };
    String params = jsonEncode(data);
    http.Response response = await http.post(
        loginUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      print(body.toString());

      User user =  User.fromJson(body["user"]);
      print(user.toString());
      return user;
    } else {
      throw "cant get sites";
    }
  }
}
