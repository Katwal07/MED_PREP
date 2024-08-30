class QuestionStat {
  int? optionA;
  int? optionB;
  int? optionC;
  int? optionD;

  QuestionStat({this.optionA, this.optionB, this.optionC, this.optionD});

  factory QuestionStat.fromJson(Map<String, dynamic> json) {
    return QuestionStat(
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
    );
  }
}
