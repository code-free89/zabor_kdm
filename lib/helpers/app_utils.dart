import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kds/constants/shared_pref_keys.dart';
import 'package:kds/models/login_response_model.dart';

class AppUtils {
  static void saveFirebaseDeviceToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(SharedPrefKeys.deviceToken, token);
  }

  static Future<String?> getDeviceToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPrefKeys.deviceToken) == null
        ? ''
        : pref.getString(SharedPrefKeys.deviceToken);
  }

  static void saveUser(User userModel) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> json = userModel.toJson();
    pref.setString(SharedPrefKeys.userModel, jsonEncode(json));
    pref.setBool(SharedPrefKeys.userLoggedIn, true);
  }

  // static void saveSettings(Setting setting) async {
  //   final pref = await SharedPreferences.getInstance();
  //   Map<String, dynamic> json = setting.toJson();
  //   pref.setString(SharedPrefKeys.settings, jsonEncode(json));
  // }

  static Future<bool> isUserLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKeys.userLoggedIn) ?? false;
  }

  static void saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(SharedPrefKeys.userAccessToken, token);
  }

  static void setIsFirstTime(bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefKeys.isFirstTime, value);
  }

  static void setIsRated(bool value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefKeys.isRated, value);
  }

  static void setPrinters(List<String> value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(SharedPrefKeys.isPrinter, value);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(SharedPrefKeys.userAccessToken) == null
        ? ''
        : pref.getString(SharedPrefKeys.userAccessToken);
  }

  static Future<bool?> getIsFirstTime() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKeys.isFirstTime) == null
        ? false
        : pref.getBool(SharedPrefKeys.isFirstTime);
  }

  static Future<bool?> getIsRated() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKeys.isRated) == null
        ? false
        : pref.getBool(SharedPrefKeys.isRated);
  }

  static Future<List<String>?> getPrinters() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList(SharedPrefKeys.isPrinter);
  }

  static void logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(SharedPrefKeys.userLoggedIn);
    pref.remove(SharedPrefKeys.userModel);
    pref.remove(SharedPrefKeys.userAccessToken);
    pref.remove(SharedPrefKeys.isLogin);
  }

  static Future<User?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString(SharedPrefKeys.userModel);
    if (jsonString == null) {
      pref.setBool(SharedPrefKeys.userLoggedIn, false);
      return null;
    }
    final json = jsonDecode(jsonString);
    final user = User.fromJson(json);
    return user;
  }

  // static Future<Setting> getSetting() async {
  //   final pref = await SharedPreferences.getInstance();
  //   final jsonString = pref.getString(SharedPrefKeys.settings);
  //   final json = jsonDecode(jsonString);
  //   final setting = Setting.fromJson(json);
  //   return setting;
  // }
}
