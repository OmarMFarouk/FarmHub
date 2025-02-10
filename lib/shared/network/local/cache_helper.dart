import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_udid/flutter_udid.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static late String deviceId;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    deviceId = await FlutterUdid.udid;
    getData(key: 'active') ?? saveData(key: 'active', value: false);
    getData(key: 'onboarded') ?? saveData(key: 'onboarded', value: false);
    CacheHelper.sharedPreferences.getStringList('search_history') ??
        CacheHelper.sharedPreferences.setStringList('search_history', []);
    CacheHelper.sharedPreferences.getStringList('listings_history') ??
        CacheHelper.sharedPreferences.setStringList('listings_history', []);
    CacheHelper.sharedPreferences.getStringList('insights_history') ??
        CacheHelper.sharedPreferences.setStringList('insights_history', []);
  }

  static Future<bool> setBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is List) {
      return await sharedPreferences.setStringList(key, value as List<String>);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({required key}) async {
    return await sharedPreferences.remove(key);
  }
}
