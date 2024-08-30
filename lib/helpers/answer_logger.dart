import 'package:med_prep/services/api_service.dart';

import '../locator.dart';

class AnswerLogger {
  // Log Answer Function

  Api _api = locator<Api>();

  Future<bool> postUserStat({
    required int timeTaken,
    required String question,
    required String selectedAnswer,
  }) async {
    try {
      // API request to server
      await _api.postUserStat(
        timeTaken: timeTaken,
        question: question,
        selectedAnswer: selectedAnswer,
      );
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
