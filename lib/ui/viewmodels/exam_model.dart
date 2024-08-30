// ignore_for_file: missing_return


import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/exam.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class ExamViewModel extends BaseModel {
  ExamListTotal? _examList;

  ExamListTotal? get getExamList => _examList;

  Api _api = locator<Api>();

  String? message;

  // StorageService _storageService = locator<StorageService>();

  Future<bool> fetchListOfExams({int? page = 1}) async {
    setState(ViewState.Busy);

    try {
      ExamListTotal examList = await _api.getAllExams(page: page ?? 1);
      _examList = examList;
      setState(ViewState.Idle);
      return true;
    } catch (err) {
      message = err.toString();
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool?> fetchMoreExams({int? page}) async {
    return null;
  }
}
