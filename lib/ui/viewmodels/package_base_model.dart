import 'package:flutter/material.dart';

import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/packages.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class PackageViewModel extends BaseModel {
  PackageList? packagesList;
  PackageList? get packageList => packagesList;
  Api _api = locator<Api>();

  String? message;

  // StorageService _storageService = locator<StorageService>();

  Future<bool> fetchListOfPackage(BuildContext context) async {
    setState(ViewState.Busy);

    try {
      PackageList packageList = await _api.getMyPackage();
      packagesList = packageList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }
}
