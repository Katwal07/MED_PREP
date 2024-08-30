// ignore_for_file: unused_field

import '../../common/tools.dart';
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../services/authentication_service.dart';
import 'base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String _errorMessage = '';

  Future<bool> login(String emailText, String passwordText) async {
    setState(ViewState.Busy);

    var email = emailText.trim();

    // Validation Here
    bool success;
    try {
      success = await _authenticationService.login(email, passwordText);
    } catch (err) {
      _errorMessage = 'Login Failed. Please Try Again';
      success = false;
    }

    if (!success) {
      Tools.showErrorToast('Login Attempt was failed! Please try again.');
    }

    // Handle potential error here too.
    await Future.delayed(Duration(seconds: 1), () {
      setState(ViewState.Idle);
    });

    return success;
  }
}
