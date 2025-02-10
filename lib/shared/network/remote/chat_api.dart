import 'dart:convert';
import 'dart:developer';

import 'package:farm_hub/shared/network/remote/end_points.dart';
import 'package:http/http.dart' as http;

import '../../../logic/user/user_cubit.dart';

class ChatsApi {
  Future fetchChats() async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.showChats), body: {
        'user_id': currentUser!.user!.id.toString(),
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

  Future sendMessage(
      {required String messageBody,
      required String roomId,
      required String participantId}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.sendMessage), body: {
        'user_id': currentUser!.user!.id.toString(),
        'room_id': roomId,
        'message_body': messageBody,
        'participant_id': participantId,
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

  Future readMessage({required String roomId}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.readMessage), body: {
        'user_id': currentUser!.user!.id.toString(),
        'room_id': roomId,
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
}
