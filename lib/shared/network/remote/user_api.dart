import 'dart:convert';
import 'dart:developer';

import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:farm_hub/shared/network/local/cache_helper.dart';
import 'package:http/http.dart' as http;
import 'package:platform_file/platform_file.dart';

import 'end_points.dart';

class UserApi {
  Future fetchUserData() async {
    try {
      http.Response request = await http.post(Uri.parse(EndPoints.userData),
          body: {'user_id': CacheHelper.getData(key: 'user_id').toString()});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future editUserProfile(
      {required String fullName,
      required String orgName,
      required String phone,
      required String email}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.editProfile), body: {
        'user_id': currentUser!.user!.id.toString(),
        'user_fullName': fullName,
        'user_orgName': orgName,
        'user_phone': phone,
        'user_email': email
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future editUserAvatar({required PlatformFile file}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoints.editAvatar),
      );
      Map<String, String> data = {'user_id': currentUser!.user!.id!.toString()};
      request.fields.addAll(data);

      request.files.add(http.MultipartFile.fromBytes(
          "file", file.bytes as List<int>,
          filename: file.name));

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = await jsonDecode(respStr);
      if (response.statusCode < 300) {
        print('a71a');
        return jsonData;
      } else {
        return 'error';
      }
    } catch (e) {
      print('a7a');
      log(e.toString());
      return 'error';
    }
  }

  Future fetchProfile({required String userId}) async {
    try {
      http.Response request = await http
          .post(Uri.parse(EndPoints.showProfile), body: {'user_id': userId});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }
}
