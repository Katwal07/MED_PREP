import 'package:flutter/material.dart';
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/treasures.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class TreasuresViewModel extends BaseModel {
  TreasuresList? _treasuresList;
  TreasuresList? get treasuresList => _treasuresList;

  Api _api = locator<Api>();

  String? message;

  Future<bool> fetchListOfTreasures(BuildContext context) async {
    setState(ViewState.Busy);

    try {
      TreasuresList treasuresList = await _api.getPdfTreasuresData();
      _treasuresList = treasuresList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }
}
