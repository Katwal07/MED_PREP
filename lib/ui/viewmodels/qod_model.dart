

import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/question.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class QuestionOfDayModel extends BaseModel {
  Question? _qodQuestion;

  Question? get qodQuestion => _qodQuestion;

  bool get hasQuestion => _qodQuestion != null;

  Api _api = locator<Api>();
  Future<bool> getQuestionOfDay() async {
    setState(ViewState.Busy);
    try {
      // await Future.delayed(Duration(seconds: 20));
      final Question? fetchedQuestion =
          await _api.getQuestionOfTheDay();

      if (fetchedQuestion != null) {
        _qodQuestion = fetchedQuestion;
        setState(ViewState.Idle);
        return true;
      }
      setState(ViewState.Idle);
      return false;
    } catch (err) {
      print(err);
      setState(ViewState.Idle);
      return false;
    }
  }
}
