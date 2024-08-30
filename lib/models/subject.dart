class Subject {
  int? noOfQuestions;
  String? name;

  Subject({this.noOfQuestions, this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        name: json['id'], noOfQuestions: json['total']);
  }
}

class SubjectList {
  List<Subject> subjects;

  SubjectList(this.subjects);

  factory SubjectList.fromJson(List<dynamic> json) {
    List<Subject> subjectList = json
        .where((element) => element != null)
        .toList()
        .map((i) => Subject.fromJson(i))
        .toList();

    return SubjectList(subjectList);
  }
}
