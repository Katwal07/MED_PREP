

import '../models/chapter.dart';
import '../ui/widgets/home/subject_icon_items.dart';

class QueryFilterHelpers {
  static Map<String, dynamic> returnQueryFilterForQuestion({
    List<SubjectItem>? selectedSubjects,
    List<Chapter>? selectedChapters,
    List<int>? years,
    int? totalQuestions,
  }) {
    Map<String, dynamic> queryParameters = {};

    // Check for List of Subjects
    if (selectedSubjects != null && selectedSubjects.isNotEmpty) {
      List<String> selectedSubjectNames = [];
      selectedSubjects.forEach((el) {
        selectedSubjectNames.add(el.section!.id!);
      });

      String joinedSubjects = selectedSubjectNames.join('-');

      queryParameters['section'] = joinedSubjects;
    }
    // debugger();

    if (selectedChapters != null && selectedChapters.isNotEmpty) {
      List<String> selectedChapterId = [];
      selectedChapters.forEach((el) {
         if (el.id != null) {
          selectedChapterId.add(el.id!);
        }
      });

      String joinnedChapters = selectedChapterId.join('-');

      queryParameters['chapter'] = joinnedChapters;
    }

    // Check for Years

    if (years != null && years.isNotEmpty) {
      String joinedYears = years.join('-');

      queryParameters['year'] = joinedYears;
    }

    // Check for Limit

    if (totalQuestions != null) {
      if (totalQuestions <= 200 && totalQuestions >= 10) {
        queryParameters['limit'] = totalQuestions;
      } else {
        queryParameters['limit'] = 10;
      }
    }

    return queryParameters;
  }
}
