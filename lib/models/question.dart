import 'dart:convert';

import '../enums/correct_answer.dart';

class Question {
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  AnswerOption? correctAnswer;
  String? extractedFrom;
  String? program;
  String? chapter;
  String? explanation;
  int? year;
  String? section;
  String? id;

  Question({
    this.question,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.correctAnswer,
    this.explanation,
    this.year,
    this.section,
    this.program,
    this.chapter,
    this.extractedFrom,
    this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    AnswerOption myCorrectAnswer;

    switch (json['correctAnswer']) {
      case 'A':
        myCorrectAnswer = AnswerOption.A;
        break;
      case 'B':
        myCorrectAnswer = AnswerOption.B;
        break;
      case 'C':
        myCorrectAnswer = AnswerOption.C;
        break;
      case 'D':
        myCorrectAnswer = AnswerOption.D;
        break;
      default:
        myCorrectAnswer = AnswerOption.A;
        break;
    }
    return Question(
      question: json['question'],
      optionA: json['optionA'] ?? '',
      optionB: json['optionB'] ?? '',
      optionC: json['optionC'] ?? '',
      optionD: json['optionD'] ?? '',
      correctAnswer: myCorrectAnswer,
      explanation: json['explanation'] ?? '',
      year: json['year'] ?? 0,
      section: json['section']['name'] != null ? json['section']['name'] : '',
      chapter: json['chapter']['name'] ?? '',
      extractedFrom: json['extractedFrom'] ?? '',
      program: json['program']['name'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': HtmlEscape().convert(this.question ?? ''),
      'optionA': this.optionA ?? '',
      'optionB': this.optionB ?? '',
      'optionC': this.optionC ?? '',
      'optionD': this.optionD ?? '',
      'correctAnswer': this.correctAnswer != null
          ? _answerOptionToString(this.correctAnswer!)
          : '',
      'explanation': HtmlEscape().convert(this.explanation ?? ''),
      'year': this.year,
      'section': this.section,
      'program': this.program,
      'chapter': this.chapter,
      'extractedFrom': this.extractedFrom,
      'id': this.id,
    };
  }

  String _answerOptionToString(AnswerOption answerOption) {
    if (answerOption == AnswerOption.A) {
      return 'A';
    } else if (answerOption == AnswerOption.B) {
      return 'B';
    } else if (answerOption == AnswerOption.C) {
      return 'C';
    } else {
      return 'D';
    }
  }
}

class QuestionList {
  final List<Question> questions;

  QuestionList(this.questions);

  factory QuestionList.fromJson(List<dynamic> json) {
    List<Question> questionList = json
        .where((element) => element != null)
        .toList()
        .map((i) => Question.fromJson(i))
        .toList();

    return QuestionList(questionList);
  }
}
