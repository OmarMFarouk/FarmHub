import 'dart:convert';
import 'dart:developer';

import '../../models/user_model.dart';
import 'end_points.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future registerUser({required User user}) async {
    try {
      http.Response request = await http.post(Uri.parse(EndPoints.register),
          body: user.registerJson());
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future loginUser({required User user}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.login), body: user.loginJson());
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future handleOTP({required String email}) async {
    try {
      http.Response request = await http
          .post(Uri.parse(EndPoints.handleOTP), body: {'user_email': email});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        print(response);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future changePassword(
      {required String password, required String email}) async {
    try {
      http.Response request = await http.post(
          Uri.parse(EndPoints.changePassword),
          body: {'user_password': password, 'user_email': email});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }
}
