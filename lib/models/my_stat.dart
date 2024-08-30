class MyStat {
  int? totalQuestionAttempt;
  int? totalCorrectAttempt;
  int? averageTimePerQuestion;
  int? dailyQuestionAttempt;
  int? weeklyQuestionAttempt;

  MyStat({
    this.totalCorrectAttempt,
    this.totalQuestionAttempt,
    this.averageTimePerQuestion,
    this.dailyQuestionAttempt,
    this.weeklyQuestionAttempt,
  });

  factory MyStat.fromJson(Map<String, dynamic> json) {
    return MyStat(
      totalCorrectAttempt: json['data']['totalCorrectAttempt'] ?? 0,
      totalQuestionAttempt: json['data']['totalQuestionAttempt'] ?? 0,
      averageTimePerQuestion: json['data']['averageTimePerQuestion'] ?? 0,
      dailyQuestionAttempt: json['data']['dailyQuestionAttempt'] ?? 0,
      weeklyQuestionAttempt: json['data']['weeklyQuestionAttempt'] ?? 0,
    );
  }
}
