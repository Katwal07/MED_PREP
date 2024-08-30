
import '../enums/answer_state.dart';
import 'question.dart';

class TestResult {
  QuestionList questionList;
  List<AnswerState> answerState;

  TestResult({
    required this.questionList,
    required this.answerState,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) {
    List<AnswerState> myAnswerState = [];

    json['answerState'].forEach((state) {
      myAnswerState.add(answerIntToState(state));
    });
    return TestResult(
        questionList:
            QuestionList.fromJson(json['questions']),
        answerState: myAnswerState);
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> myQuestions = [];
    List<int> myAnswers = [];

    questionList.questions.forEach((qsn) {
      myQuestions.add(qsn.toMap());
    });

    answerState.forEach((ans) {
      myAnswers.add(_answerStateToInt(ans));
    });

    return {
      'questions': myQuestions,
      'answerState': myAnswers
    };
  }

  int _answerStateToInt(AnswerState answerState) {
    if (answerState == AnswerState.Correct) {
      return 0;
    } else if (answerState == AnswerState.Wrong) {
      return 1;
    } else {
      return 2;
    }
  }
}

AnswerState answerIntToState(int answerState) {
  if (answerState == 0) {
    return AnswerState.Correct;
  } else if (answerState == 1) {
    return AnswerState.Wrong;
  } else {
    return AnswerState.NotDefiend;
  }
}

class TestResultList {
  List<TestResult> testResults;

  TestResultList(this.testResults);

  factory TestResultList.fromJson(List<dynamic> json) {
    List<TestResult> testResultList = json
        .where((element) => element != null)
        .toList()
        .map((x) => TestResult.fromJson(x))
        .toList();

    return TestResultList(testResultList);
  }

  List<dynamic> toList() {
    return testResults.map((d) => d.toMap()).toList();
  }
}
