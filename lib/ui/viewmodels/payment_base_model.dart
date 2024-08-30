import 'package:flutter/material.dart';

import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/payment.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class PaymentViewModel extends BaseModel {
  PaymentList? _paymentList;
  PaymentList? get paymentList => _paymentList;
  Api _api = locator<Api>();

  String? message;

  // StorageService _storageService = locator<StorageService>();

  Future<bool> fetchListOfPayments(BuildContext context) async {
    setState(ViewState.Busy);

    try {
      PaymentList paymentList = await _api.getMyPayment();
      _paymentList = paymentList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }
}
