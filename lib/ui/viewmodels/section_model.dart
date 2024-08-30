import 'package:flutter/material.dart';
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/section.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class SectionViewModel extends BaseModel {
  SectionList? _sectionList;
  var tags;
  SectionList? get sectionList => _sectionList;

  Api _api = locator<Api>();

  String? message;

  // StorageService _storageService = locator<StorageService>();

  Future<bool> fetchListOfSections(BuildContext context, String tag) async {
    setState(ViewState.Busy);

    try {
      SectionList sectionList = await _api.getSectionData(tags: tag);
      _sectionList = sectionList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }
}
