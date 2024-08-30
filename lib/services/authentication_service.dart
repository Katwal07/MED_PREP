// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import '../common/tools.dart';
import '../locator.dart';
import '../models/user.dart';
import 'api_service.dart';
import 'package:get/get.dart';
import '../ui/screens/email-verification/not_verified_screen.dart';
import 'storage_service.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  StorageService _storageService = locator<StorageService>();

  Future<void> logout() async {
    return _storageService.clearAllStorage();
  }

  Future<bool> login(String email, String password) async {
    User fetchedUser;
    try {
      fetchedUser = (await _api.login(email, password))!;
      // Get.snackbar(
      //   'Welcome, ${fetchedUser.name}',
      //   'Successfully Logged In.',
      //   colorText: Colors.white,
      //   backgroundColor: Colors.green,
      //   snackPosition: SnackPosition.TOP,
      //   barBlur: 0,
      // );

    } catch (err) {
      throw err;
    }

    var hasUser = fetchedUser != null;

    if (hasUser) {
      // _authProvider.userModel = fetchedUser;
      if (fetchedUser.isUserVerified == false) {
        Get.offAll(NotVerifiedScreen(
          user: fetchedUser,
        ));
        return false;
      } else {
        userController.add(fetchedUser);
      }
    }

    return hasUser;
  }

  Future<bool> signup(String name, String email, String password,
      String confirmPassword) async {
    // debugger();
    User fetchedUser;
    try {
      fetchedUser = await _api.signup(name, email, password, confirmPassword);
    } catch (err) {
      return false;
    }

    var hasUser = fetchedUser != null;

    if (hasUser) {
      if (fetchedUser.isUserVerified == false) {
        Get.offAll(NotVerifiedScreen(
          user: fetchedUser,
        ));
        Tools.showErrorToast('Please verify your email');

        return false;
      } else {
        userController.add(fetchedUser);
      }
    }

    return hasUser;
  }
}
