import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants.dart';
import '../models/user.dart';

class StorageService {
  static const authUserKey = 'authUser';

  // Create storage
  final storage = new FlutterSecureStorage();

  Future<void> clearAllStorage() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.clear();
      await storage.deleteAll();
    } catch (err) {
      print('Error Clearing out all storage');
    }
  }

  Future<Future<String?>> readValueFromSecureStorage(key) async {
    return storage.read(key: key);
  }

  Future<void> writeValueToSecureStorage(String key, String value) {
    return storage.write(key: key, value: value);
  }

  Future<void> removeKeyValueFromSecureStroage(key) {
    return storage.delete(key: key);
  }

  Future<bool> saveUser(String user) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(authUserKey, user);
  }

  Future<bool> saveProgramId(String id) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(id, id);
  }

  Future<bool> setBoolToSharedPrefs({bool? data, String? key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key!, data!);
  }

  Future<bool> getBoolFromSharedPrefs({String? key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key!)!;
  }

  Future<bool> saveDataToSharedPrefs({dynamic data, String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.setString(key!, data);
    // prefs.reload();
  }

  Future<bool> removeDataFromSharedPrefs({String? key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.remove(key!);
  }

  Future<String> getDataFromSharedPrefs({String? key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key!)!;
  }

  Future<bool> getBoolFromSharefPrefs({String? key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key!)!;
  }

  Future<bool> setStringToSharedPrefs({String? key, bool? value}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key!, value!);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString(authUserKey);

    User? storedUser;

    if (user != null) {
      storedUser = User.fromJson(json.decode(user));
    } else {
      storedUser = null;
    }

    return Future.value(storedUser);
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(authUserKey);
  }

  Future<void> logout() async {
    await clearUser();
    await removeDataFromSharedPrefs(key: ACCESS_TOKEN_KEY);

    await removeKeyValueFromSecureStroage(ACCESS_TOKEN_KEY);
  }

  Future<bool> saveImage(String imageName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("IMAGE", imageName);
  }

  Future<String?> getImage() async {
    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString("IMAGE");

    return user;
  }
}
