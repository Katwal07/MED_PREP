import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants.dart';
import '../services/dio_instance.dart';
import '../ui/widgets/home/subject_icon_items.dart';

class QuestionHelper {
  Future<dynamic> getNoOfQuestionAvailableInSubject(
      {required SubjectItem subjectItem}) async {
    var dio = await getDioInstance();
    try {
      // Try to get from store
      final prefs = await SharedPreferences.getInstance();

      final savedSubjects = prefs.getString(CACHE_SUBJECT_KEY);

      if (savedSubjects == null) {
        // print("null subjects in store");
        final res =
            await dio.get('/chapters/section/${subjectItem.section!.id}');
        if (res.statusCode == 200) {
          if (res.data['data'] is List) {
            await prefs.setString(
                CACHE_SUBJECT_KEY, jsonEncode(res.data['data']));
            return getTotalQuestions(res.data['totalQuestions'], subjectItem);
          }

          return {"total": 10, "chapters": {}};
        } else {
          return {"total": 0, "chapters": {}};
        }
      } else {
        final decodedSubjects = jsonDecode(savedSubjects);

        return getTotalQuestions(decodedSubjects, subjectItem);
      }

      // if (subjectList == null &&
      //     subjectList.subjects.isEmpty) {
      //   return 0;
      // }

      // int questionCount = 0;

      // subjectList.subjects.forEach((subject) {
      //   if (subject.name == subjectItem.slug) {
      //     questionCount = subject.noOfQuestions;
      //   }
      // });

      // return questionCount;
    } catch (err) {
      printLog(err);

      return {"total": 0, "chapters": {}};
    }
  }

  dynamic getTotalQuestions(dynamic, SubjectItem subjectItem) {
    var totalQuestion = 0;

    var myMap = {};

    dynamic.forEach((obj) {
      if (obj["id"]["sectionName"] == subjectItem.section!.id) {
        totalQuestion += (obj["total"] as num).toInt();
        if (obj["id"]["chapter"] != null && obj["id"]["chapter"] != '') {
          final keyValue = obj["id"]["chapter"];
          myMap.putIfAbsent(keyValue, () => obj['total']);
        }
      }
    });

    return {...myMap, "total": totalQuestion};
  }
}
