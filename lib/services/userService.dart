import 'dart:convert';
import 'package:univ_chat_gpt/app/Constants.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart';

class UserService {
  static const signInUrl = "user/signin";
  static const signUpUrl = "user/signup";
  static const otpUrl = "user/sendOTP";
  static const otpVerifyUrl = "user/verifyotp";
  static const changePwd = "user/resetpwd";

  static Future<http.Response> postLogin(String email, String pwd) async {
    Uri signInUri = Uri.parse(baseUrl + signInUrl);
    final data = {"email": email, "pwd": pwd};
    String params = jsonEncode(data);
    http.Response response =
        await http.post(signInUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> postSignUp(
      String fullName, String email, String pwd) async {
    Uri SignUpUri = Uri.parse(baseUrl + signUpUrl);
    final data = {"fullname": fullName, "email": email, "pwd": pwd};
    String params = jsonEncode(data);
    http.Response response =
        await http.post(SignUpUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> postSendOTP(String email) async {
    Uri sendOTPUri = Uri.parse(baseUrl + otpUrl);
    final data = {"email": email};
    String params = jsonEncode(data);
    http.Response response =
        await http.post(sendOTPUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> postVerifyOTP(String email, int otp) async {
    Uri verifyOTPUri = Uri.parse(baseUrl + otpVerifyUrl);
    final data = {"email": email, "otp": otp};
    String params = jsonEncode(data);
    http.Response response =
        await http.post(verifyOTPUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> putResetPwd(String email, String pwd) async {
    Uri changePwdURI = Uri.parse(baseUrl + changePwd);
    final data = {"email": email, "new_pwd": pwd};
    String params = jsonEncode(data);
    http.Response response =
        await http.put(changePwdURI, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }
}
