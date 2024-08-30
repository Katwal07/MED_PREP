import '../../locator.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

Api _api = locator<Api>();

class AccountModel extends BaseModel {
  bool _enableNotification = true;

  // _api.getMe().then((value) => _enableNotifica );

  bool get enableNotification => _enableNotification;

  void toggleNotificationSwitch(bool value) async {
    // debugger();

    try {
      _api
          .updatePushNotification(value)
          .then((response) => _enableNotification = value);
      // _enableNotification = value;
    } catch (e) {
      _enableNotification = _enableNotification;
    }
    notifyListeners();
  }
}
