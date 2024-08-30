class ExamListTotal {
  int? total;
  int? result;
  ExamList? exams;
  ExamListTotal({
    this.total,
    this.result,
    this.exams,
  });
  factory ExamListTotal.fromJson(Map<String, dynamic> json) {
    return ExamListTotal(
      total: json['total'],
      result: json['result'],
      exams: ExamList.fromJson(json['data']),
    );
  }
}

class ExamModel {
  String? id;
  String? name;
  int? totalQuestions;
  String? type;
  int? time;
  int? startDate;
  int? endDate;

  ExamModel({
    this.id,
    this.name,
    this.totalQuestions,
    this.type,
    this.time,
    this.startDate,
    this.endDate,
  });
  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] != null ? json['id'] : '',
      name: json['name'] != null ? json['name'] : '',
      totalQuestions:
          json['questions'].length != null ? json['questions'].length : 0,
      type: json['type'] != null ? json['type'] : '',
      time: json['time'] != null ? json['time'] : 0,
      startDate: json['startDate'] != null ? json['startDate'] : '',
      endDate: json['endDate'] != null ? json['endDate'] : '',
    );
  }
}

class ExamList {
  List<ExamModel> exams;

  ExamList(this.exams);

  factory ExamList.fromJson(List<dynamic> json) {
    List<ExamModel> examList = json
        .where((element) => element != null)
        .toList()
        .map((i) => ExamModel.fromJson(i))
        .toList();

    return ExamList(examList);
  }
}
