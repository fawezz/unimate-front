
import 'dart:convert';

import 'package:univ_chat_gpt/app/Constants.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart';

class UserService{
  static const signInUrl = "user/signin";
  static const signUpUrl = "user/signup";

  static Future<http.Response> postLogin(String email, String pwd) async {
    Uri signInUri = Uri.parse(baseUrl + signInUrl);
    final data = {
      "email": email,
      "pwd": pwd
    };
    String params = jsonEncode(data);
    http.Response response = await http.post(
        signInUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> postSignUp(String fullName, String email, String pwd) async {
    Uri SignUpUri = Uri.parse(baseUrl + signUpUrl);
    final data = {
      "fullname" : fullName,
      "email": email,
      "pwd": pwd
    };
    String params = jsonEncode(data);
    http.Response response = await http.post(
        SignUpUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }
}
