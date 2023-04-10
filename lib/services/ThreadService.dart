import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app/Constants.dart';
import '../models/ThreadModel.dart';

class ThreadService {
  static const predictThreadUrl = "question/predictag";
  static const predictSeqResponseUrl = "question/getseqrep";

  static const getThreadsByUserUrl = "thread/getall";
  static const getThreadByIdUrl = "thread/getone";
  static const deleteThreadByIdUrl = "thread/delete";

  static final client = http.Client();

  static Future<List<Thread>?> getThreadsByUser() async {
    Uri uri = Uri.parse(baseUrl + getThreadsByUserUrl);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    try {
      http.Response response = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }).timeout(const Duration(seconds: 7), onTimeout: () {
        throw TimeoutException('The connection has timed out');
      });
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Thread> threads = <Thread>[];
      if (response.statusCode == 200) {
        List<dynamic> jsonThreads = body['threads'];
        jsonThreads.forEach((element) {
          threads.add(Thread.fromJson(element));
        });
        return threads;
      }
      if (response.statusCode == 404) {
        return threads;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<http.Response> getThreadById(String threadId) async {
    Uri uri = Uri.parse("$baseUrl$getThreadByIdUrl/$threadId");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final data = {"threadId": threadId};
    String params = jsonEncode(data);
    http.Response response = await client.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    return response;
  }

  static Future<http.Response> deleteThread(String threadId) async {
    Uri uri = Uri.parse("$baseUrl$deleteThreadByIdUrl/$threadId");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final data = {"threadId": threadId};
    String params = jsonEncode(data);
    http.Response response = await client.delete(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    return response;
  }

  static Future<http.Response> postPredictTag(String question) async {
    Uri sendOTPUri = Uri.parse(baseUrl + predictThreadUrl);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final data = {"prompt": question};
    String params = jsonEncode(data);
    http.Response response =
        await client.post(sendOTPUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    return response;
  }

  static Future<http.Response> postQuestion(
      String question, String? threadId) async {
    Uri sendOTPUri = Uri.parse(baseUrl + predictSeqResponseUrl);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    final data = {"prompt": question, "threadId": threadId};
    String params = jsonEncode(data);
    http.Response response =
        await client.post(sendOTPUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    return response;
  }
}
