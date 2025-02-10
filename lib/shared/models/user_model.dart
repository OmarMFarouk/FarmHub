import 'package:farm_hub/shared/network/local/cache_helper.dart';

class User {
  int? id;
  String? username;
  String? fullName;
  String? email;
  String? credential;
  String? password;
  String? lastAccess;
  String? dateCreated;
  String? phone;
  String? orgName;
  String? avatar;
  String? location;
  String? followCount;
  String? followingCount;

  User(
      {this.id,
      this.username,
      this.fullName,
      this.password,
      this.lastAccess,
      this.credential,
      this.dateCreated,
      this.location,
      this.email,
      this.avatar,
      this.orgName,
      this.followCount,
      this.followingCount,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    username = json['user_name'];
    fullName = json['user_fullName'];
    email = json['user_email'];
    phone = json['user_phone'];
    location = json['user_location'];
    avatar = json['user_avatar'];
    orgName = json['user_orgName'];
    followCount = json['user_followCount'];
    followingCount = json['user_followingCount'];
    lastAccess = json['user_dateLastAccess'];
    dateCreated = json['user_dateCreated'];
  }
  Map<String, dynamic> loginJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credential'] = credential;
    data['password'] = password;
    return data;
  }

  Map<String, dynamic> registerJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = email!.split('@').first;
    data['user_fullname'] = fullName;
    data['user_email'] = email;
    data['user_password'] = password;
    data['user_location'] = location;
    data['user_phone'] = phone;
    data['user_orgName'] = orgName;
    data['user_hwid'] = CacheHelper.deviceId;
    return data;
  }
}

class UserModel {
  bool? success;
  String? message;
  User? user;

  UserModel({this.success, this.message, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = User.fromJson(json['user_data']);
  }
}
