import './question.dart';

class Result {
  bool? isCompleted;
  String? exam;
  String? id;
  List<QuestionAnswer>? questionAnswer;
  int? attemptedQuestions;
  int? totalQuestions;
  Result({
    this.id,
    this.questionAnswer,
    this.isCompleted = false,
    this.exam,
    this.attemptedQuestions,
    this.totalQuestions,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      isCompleted: json['isCompleted'],
      exam: json['exam'] != null ? json['exam']['name'] : null,
      questionAnswer: json['questionAns'] != null
          ? QuestionAnswerList.fromJson(json['questionAns'])
              .questionAnswerResults
          : [],
      attemptedQuestions: json['attemptedQuestions'],
      totalQuestions: json['totalQuestions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'questionAnswer': this.questionAnswer,
      'exam': this.exam,
      'isCompleted': this.isCompleted,
      'attemptedQuestions': this.attemptedQuestions,
      'totalQuestions': this.totalQuestions
    };
  }
}

class ResultList {
  List<Result> results;

  ResultList(this.results);

  factory ResultList.fromJson(List<dynamic> json) {
    List<Result> resultList = json
        .where((element) => element != null)
        .toList()
        .map((x) => Result.fromJson(x))
        .toList();

    return ResultList(resultList);
  }

  List<dynamic> toList() {
    return results.map((d) => d.toMap()).toList();
  }
}

class QuestionAnswer {
  String? id;
  Question? question;
  // String timeTaken;
  String? selectedAnswer;
  QuestionAnswer({
    this.question,
    this.selectedAnswer,
    this.id,
    // this.timeTaken
  });
  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    // debugger();
    return QuestionAnswer(
        id: json['id'] ?? '',
        question: Question.fromJson(json['question'] ?? ''),
        // timeTaken: json['timeTaken'],
        selectedAnswer: json['selectedAnswer'] ?? '');
  }
  Map<String, dynamic> toMap() {
    return {
      'question': this.question,
      // "timeTaken": this.timeTaken,
      'id': this.id,
      'selectedAnswer': this.selectedAnswer,
    };
  }
}

class QuestionAnswerList {
  List<QuestionAnswer> questionAnswerResults;

  QuestionAnswerList(this.questionAnswerResults);

  factory QuestionAnswerList.fromJson(List<dynamic> json) {
    List<QuestionAnswer> questionAnswertList = json
        .where((element) => element != null)
        .toList()
        .map((x) => QuestionAnswer.fromJson(x))
        .toList();

    return QuestionAnswerList(questionAnswertList);
  }

  List<dynamic> toList() {
    return questionAnswerResults.map((d) => d.toMap()).toList();
  }
}

// Testing The result Modeling

final Map<String, dynamic> resultData = {
  "page": 1,
  "total": 80,
  "perPage": 10,
  "data": [
    {
      "isCompleted": false,
      "exam": {"name": "Exam Test", "id": "614da9948eb7ab00127bdf65"},
      "questionAns": [
        {
          "selectedAnswer": "A",
          "id": "61a73de5ac30ce574ff418cc",
          "question": {
            "question": "<p>fourth question</p>",
            "correctAnswer": "B",
            "id": "614c69d38eb7ab00127bde5e"
          }
        },
        {
          "selectedAnswer": "A",
          "id": "61a73de5ac30ce574ff418cd",
          "question": {
            "question": "<p>Describe this is this?</p>",
            "correctAnswer": "B",
            "id": "614da8d48eb7ab00127bdf12"
          }
        },
        {
          "selectedAnswer": "",
          "id": "61a73de5ac30ce574ff418ce",
          "question": {
            "question": "<p>describe anatomy</p>",
            "correctAnswer": "B",
            "id": "614c46d4f724d700129fa0d7"
          }
        },
        {
          "selectedAnswer": "",
          "id": "61a73de5ac30ce574ff418cf",
          "question": {
            "question": "<p>This is this</p>",
            "correctAnswer": "A",
            "id": "614c69ef8eb7ab00127bde77"
          }
        },
        {
          "selectedAnswer": "",
          "id": "61a73de5ac30ce574ff418d0",
          "question": {
            "question": "<p>Third added</p>",
            "correctAnswer": "B",
            "id": "614c69b38eb7ab00127bde45"
          }
        }
      ],
      "createdAt": "2021-12-01T09:18:29.901Z",
      "updatedAt": "2021-12-01T09:35:52.750Z",
      "id": "61a73de5ac30ce574ff418cb"
    }
  ]
};
main() {
  // ignore: unused_local_variable
  final resultsData = Result.fromJson(resultData['data'][0]);
}
