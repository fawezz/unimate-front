import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app/Constants.dart';

class ThreadService {
  static const predictThreadUrl = "thread/predictag";

  static Future<http.Response> postPreddictTag(String question) async {
    Uri sendOTPUri = Uri.parse(baseUrl + predictThreadUrl);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final data = {"prompt": question};
    String params = jsonEncode(data);
    http.Response response =
        await http.post(sendOTPUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    Map<String, dynamic> body = jsonDecode(response.body);
    print("aaaaaaaaaaa" + body.toString()); // to remove
    return response;
  }
}