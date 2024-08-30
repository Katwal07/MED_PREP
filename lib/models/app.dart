// ignore_for_file: unnecessary_type_check

import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart';
import '../config/general.dart';
import '../locator.dart';
import '../services/storage_service.dart';
import 'in_memory_local_storage.dart';
import 'user.dart';

class AppModel extends ChangeNotifier {

  User? _currentUser;
  bool _loginStatus = false;

  StorageService _storageService = locator<StorageService>();

  User? get currentUser => _currentUser;
  bool get loginStatus => _loginStatus;

  void changeLoginStatus(bool status) {
    _loginStatus = status;
    notifyListeners();
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _loginStatus = false;
    await _storageService.clearUser();
    await _storageService.removeKeyValueFromSecureStroage(ACCESS_TOKEN_KEY);
  // await _storageService.removeKeyValueFromSecureStroage(REFRESH_TOKEN_KEY);
    notifyListeners();
  }

  void setBrightness(Brightness brightness) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    brightness == Brightness.light
        ? prefs.setBool("isDark", false)
        : prefs.setBool("isDark", true);

    notifyListeners();
  }

  Map<String, dynamic> appConfig = {};
  bool isInit = false;
  bool isLoading = true;
  String message = '';

  AppModel() {
    getConfig();
  }

  Future<bool> getConfig() async {
    isInit = true;
    return true;
  }

  Future<void> loadAppConfig() async {
    try {
      if (!isInit) {
        await getConfig();
      }

      final LocalStorage storage = InMemoryLocalStorage();
      var config = await storage.getItem('config');
      if (config != null) {
         if (config is String) {
          // If config is a String, parse it as JSON
          appConfig = json.decode(config);
        } else if (config is Map<String, dynamic>) {
          // If config is already a Map, use it directly
          appConfig = config as Map<String, dynamic>;
        } else {
          throw Exception('Unexpected config type');
        }
      } else {
        // ignore: prefer_contains
        if (kAppConfig.indexOf('http') != -1) {
          // load on cloud config and update on air
          final appJson = await http.get(Uri.parse(kAppConfig),
              headers: {"Accept": "application/json"});
          appConfig = convert.jsonDecode(appJson.body);
        } else {
          // load local config
          String path = "lib/config/config_en.json";
          try {
            final appJson = await rootBundle.loadString(path);
            appConfig = convert.jsonDecode(appJson);
          } catch (e) {
            final appJson = await rootBundle.loadString(kAppConfig);
            appConfig = convert.jsonDecode(appJson);
          }
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (err) {
      isLoading = false;
      message = err.toString();
      notifyListeners();
    }
  }
}
