// ignore_for_file: unused_field

import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../services/authentication_service.dart';
import 'base_model.dart';

class SignupModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String _errorMessage = '';

  Future<bool> signup({
    String? nameText,
    String? emailText,
    String? passwordText,
    String? confirmPasswordText,
  }) async {
    setState(ViewState.Busy);

    String name = nameText!.trim();
    String email = emailText!.trim();

    // Validation here
    bool success;

    try {
      success = await _authenticationService.signup(
          name, email, passwordText!, confirmPasswordText!);
    } catch (err) {
      _errorMessage = 'Sign up Attemp was not successful';
      success = false;
    }
    print('Try this');
    print(success);

    // if (!success) {
    // Tools.showErrorToast('Sign up Attemp was not successful');
    // await Get.defaultDialog(
    //   title: "Signup Failed",
    //   content: AutoSizeText(_errorMessage ?? 'Sign up Attemp was not successful'),
    // );
    // }

    // Handle potential Error here too.

    setState(ViewState.Idle);
    return success;
  }
}
