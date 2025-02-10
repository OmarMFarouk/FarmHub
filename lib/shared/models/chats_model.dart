/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
import 'package:farm_hub/shared/models/user_model.dart';

class Chat {
  int? uid;
  String? id;
  String? user1;
  String? user2;
  String? msgCount;
  String? unReadCount;
  String? lastMsg;
  String? lastSender;
  String? dateCreated;
  String? dateUpdated;
  User? participantInfo;
  List<Message?>? messages;

  Chat(
      {this.id,
      this.uid,
      this.user1,
      this.user2,
      this.msgCount,
      this.unReadCount,
      this.lastMsg,
      this.lastSender,
      this.dateCreated,
      this.dateUpdated,
      this.participantInfo,
      this.messages});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['room_id'];
    uid = json['room_uid'];
    user1 = json['room_u1'];
    user2 = json['room_u2'];
    msgCount = json['room_msgCount'];
    unReadCount = json['room_unreadCount'];
    lastMsg = json['room_lastMsg'];
    lastSender = json['room_lastMsger'];
    dateCreated = json['room_dateCreated'];
    dateUpdated = json['room_dateUpdated'];
    participantInfo = json['participant_info'] != null
        ? User?.fromJson(json['participant_info'])
        : null;
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }
}

class Message {
  int? id;
  String? body;
  String? type;
  String? status;
  String? roomId;
  String? userId;
  String? dateCreated;

  Message(
      {this.id,
      this.body,
      this.type,
      this.status,
      this.roomId,
      this.userId,
      this.dateCreated});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['message_id'];
    body = json['message_body'];
    type = json['message_type'];
    status = json['message_status'];
    roomId = json['message_roomId'];
    userId = json['message_userId'];
    dateCreated = json['message_dateCreated'];
  }
}

class ChatsModel {
  List<Chat?>? chats;
  bool? success;
  String? message;

  ChatsModel({this.chats, this.success, this.message});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <Chat>[];
      json['chats'].forEach((v) {
        chats!.add(Chat.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}
