import 'package:flutter/material.dart';

import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/result.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class ResultViewModel extends BaseModel {
  ResultList? _resultList;
  ResultList? get resultList => _resultList;

  Api _api = locator<Api>();

  String? message;

  // StorageService _storageService = locator<StorageService>();

  Future<bool> fetchListOfResults(BuildContext context) async {
    setState(ViewState.Busy);

    try {
      ResultList resultList = await _api.getUserResults();
      _resultList = resultList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }
}
