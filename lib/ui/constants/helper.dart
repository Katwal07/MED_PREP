

import '../../enums/correct_answer.dart';
import '../../models/question.dart';

class HelperUIFunctions {
  static String? getAnswerFromSelectedAnswerOption({
    Question? question,
  }) {
    String? answer;
    switch (question!.correctAnswer) {
      case AnswerOption.A:
        answer = question.optionA!;
        break;
      case AnswerOption.B:
        answer = question.optionB!;
        break;
      case AnswerOption.C:
        answer = question.optionC!;
        break;
      case AnswerOption.D:
        answer = question.optionD!;
        break;
      case null:

    }
    return answer;
  }

  static bool isAnswerCorrect({
    Question? question,
    AnswerOption? answerOption,
  }) {
    if (question!.correctAnswer == answerOption) {
      return true;
    } else {
      return false;
    }
  }
}
