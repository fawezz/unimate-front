import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univ_chat_gpt/app/Constants.dart';
import 'package:http/http.dart' as http;
import '../models/UserModel.dart';

class UserService {
  static const signInUrl = "user/signin";
  static const signUpUrl = "user/signup";
  static const otpUrl = "user/sendOTP";
  static const otpVerifyUrl = "user/verifyotp";
  static const changePwdUrl = "user/resetpwd";
  static const userProfileUrl = "user/profile";
  static const updateProfileUrl = "user/updateprofile";
  static const uploadPictureUrl = "user/updateprofilepic";

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

  static Future<http.Response> postSignUp(String fullName, String email,
      String pwd, String? role, int? level, String? speciality) async {
    Uri SignUpUri = Uri.parse(baseUrl + signUpUrl);
    final data = {
      "fullname": fullName,
      "email": email,
      "pwd": pwd,
      "role": role,
      "level": level,
      "speciality": speciality
    };
    String params = jsonEncode(data);
    http.Response response =
        await http.post(SignUpUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<User?> getCurrentProfile() async {
    Uri userProfileUri = Uri.parse(baseUrl + userProfileUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    http.Response response =
        await http.get(userProfileUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    Map<String, dynamic> body = jsonDecode(response.body);
    User? currentUser;
    if (response.statusCode == 200) {
      currentUser = User.fromJson(body['user']);
    }
    return currentUser;
  }

  static Future<http.Response> putUpdateProfile(
      String fullName, String? pwd) async {
    Uri updateProfileUri = Uri.parse(baseUrl + updateProfileUrl);
    pwd ??= "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final data = {"fullname": fullName, "pwd": pwd};
    String params = jsonEncode(data);
    http.Response response = await http
        .put(updateProfileUri, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
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
    Uri changePwdURI = Uri.parse(baseUrl + changePwdUrl);
    final data = {"email": email, "new_pwd": pwd};
    String params = jsonEncode(data);
    http.Response response =
        await http.put(changePwdURI, body: params, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return response;
  }

  static Future<http.Response> uploadPicture(String picPath) async {
    Uri uploadPictureUri = Uri.parse(baseUrl + uploadPictureUrl);
    var request = http.MultipartRequest("PUT", uploadPictureUri);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    request.headers['authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath('pic', picPath));
    final response = await request.send();
    return http.Response.fromStream(response);
  }
/*
  static Future<String> getSchedule() async {
    Uri getScheduleUri = Uri.parse(scheduleBaseUrl);
    print("inside get schedule");
    http.Response response = await http.get(getScheduleUri);
    //if (response.statusCode == 200) {
    var dir = await getTemporaryDirectory();
    print(dir);
    File file = File(dir.path + "/emploie.pdf");
    await file.writeAsBytes(response.bodyBytes, flush: true);
    //}
    return file.path;
  }*/
}
