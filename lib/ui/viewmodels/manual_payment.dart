
// ignore_for_file: unused_field

import 'dart:io';
import '../../common/tools.dart';
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/payment.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class ManualPaymentModel extends BaseModel {
  // final Api _api =
  //     locator<Api>();
  Api _api = locator<Api>();

  String _errorMessage = '';

  Future<Payment?> manualpayment({
    String? paidText,
    String? noteText,
    File? imageFile,
    String? packageText,
    String? dateFrom,
  }) async {
    setState(ViewState.Busy);

    // String name = nameText.trim();

    // Validation here
    // bool success;
//

    try {
      final res = await _api.manualpayment(
          paidText!, noteText!, imageFile!, packageText!, dateFrom!);
      return res;
    } catch (err) {
      _errorMessage = 'Payment was not successful';
      // res = false;
    }

    // if (res.ststa) {
    //   Tools.showErrorToast('Payment was not successful');
    //   // await Get.defaultDialog(
    //     title: "Signup Failed",
    //     content: AutoSizeText(_errorMessage ?? 'Sign up Attemp was not successful'),
    //   );
    //   }}

    //   // Handle potential Error here too.

    setState(ViewState.Idle);
    Tools.showErrorToast('Payment was successful');
    return null;

    // return success;
  }
}
// }
