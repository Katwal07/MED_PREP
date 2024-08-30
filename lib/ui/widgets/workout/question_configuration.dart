

import '../../../models/chapter.dart';
import '../home/subject_icon_items.dart';

class QuestionConfiguration {
  final bool isSimulateTest;
  final int timeInMinute;
  final int totalQuestion;
  final String? difficuly;
  final List<int>? selectedYears;
  final List<SubjectItem>? subjects;
  final List<Chapter>? chapters;

  QuestionConfiguration({
    this.isSimulateTest = false,
    this.timeInMinute = 60,
    this.totalQuestion = 100,
    this.difficuly,
    this.selectedYears,
    this.subjects,
    this.chapters,
  });
}
