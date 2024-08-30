import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../locator.dart';
import '../services/api_service.dart';
import 'constants.dart';

abstract class FirebaseCloudMessagagingAbs {
  init();
  FirebaseCloudMessagingDelegate? delegate;
}

abstract class FirebaseCloudMessagingDelegate {
  onMessage(Map<String, dynamic> message);
  onResume(Map<String, dynamic> message);
  onLaunch(Map<String, dynamic> message);
}

class FirebaseCloudMessagagingWapper extends FirebaseCloudMessagagingAbs {
  FirebaseMessaging? _firebaseMessaging;

  Api _api = locator<Api>();

  @override
  init() {
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
    getAndPushToken();
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) =>
    //       delegate?.onMessage(message),
    //   onResume: (Map<String, dynamic> message) =>
    //       delegate?.onResume(message),
    //   onLaunch: (Map<String, dynamic> message) =>
    //       delegate?.onLaunch(message),
    // );
  }

  Future<String?> getAndPushToken() async {
    String? token = await _firebaseMessaging!.getToken();
    try {
      await _api.updatePushNotificationToken(token!);
    } catch (err) {
      printLog(err);
    }
    return token;
  }

  void iOSPermission() {
    printLog('Requesting for iOS Notification');
    // _firebaseMessaging.requestNotificationPermissions(
    //     IosNotificationSettings(
    //         sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {});
  }
}
