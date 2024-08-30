// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../common/constants.dart';
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/notification.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';
import 'base_model.dart';

class NotificationModel extends BaseModel {
  late NotificationList _notificationList;

  int _page = 1;
  int _limit = 6;

  Api _api = locator<Api>();
  StorageService _storageService = locator<StorageService>();

  NotificationList get notifications => _notificationList;

  Future<void> fetchNotifications(BuildContext context) async {
    _page = 1;

    setState(ViewState.Busy);
    // final token = await _storageService.readValueFromSecureStorage('JWT_TOKEN');
    try {
      NotificationList notificationList =
          await _api.fetchNotifications(_page, _limit);
      // ProductList productList = await _api.getProducts(token);
      // final stringFromJson = await DefaultAssetBundle.of(context)
      //     .loadString('assets/json/notifications.json');
      // final List<dynamic> jsonMap = json.decode(stringFromJson);
      // NotificationList notificationList = NotificationList.fromJson(jsonMap);

      if (notificationList == null) {
        final cachedRes = await _storageService.getDataFromSharedPrefs(
            key: CACHE_NOTIFICATION_KEY);
        if (cachedRes != null) {
          final decodedRes = jsonDecode(cachedRes);
          notificationList = NotificationList.fromJson(decodedRes['data']);
        } else {
          _notificationList.notifications = [];
          return;
        }
      }

      setState(ViewState.Idle);
      _notificationList = notificationList;
    } catch (err) {
      if (_notificationList == null) {
        final cachedRes = await _storageService.getDataFromSharedPrefs(
            key: CACHE_NOTIFICATION_KEY);

        if (cachedRes != null) {
          final decodedRes = jsonDecode(cachedRes);
          _notificationList = NotificationList.fromJson(decodedRes['data']);
        } else {
          if (_notificationList != null) {
            _notificationList.notifications = [];
          }
        }
      } else {
        setState(ViewState.Idle);
        return;
      }
      setState(ViewState.Idle);
      return null;
    }
  }

  Future<int> fetchMoreNotification() async {
    ++_page;
    print(_page);
    try {
      NotificationList notificationList =
          await _api.fetchNotifications(_page, _limit);

      if (notificationList == null) {
        --_page;
        return 0;
      }

      if (notificationList.notifications.length > 0) {
        // if (notificationList.notifications.length < _limit) {
        //   --_page;
        //   for (int i = 0; i < notificationList.notifications.length; i++) {
        //     _notificationList.notifications.removeLast();
        //   }
        // }

        notificationList.notifications.forEach((n) {
          _notificationList.notifications.add(n);
        });
        notifyListeners();

        return 1;
      } else {
        --_page;
        return 0;
      }
    } catch (err) {
      --_page;
      return 0;
    }
  }
}
