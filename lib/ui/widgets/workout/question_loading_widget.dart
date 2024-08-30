import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import '../../../common/constants.dart';
import '../../../helpers/query_filter_helpers.dart';
import '../../../locator.dart';
import '../../../models/question.dart';
import '../../../models/result.dart';
import '../../../services/api_service.dart';
import '../../../tabbar.dart';
import '../../screens/practice/exam_screen.dart';
import 'question_configuration.dart';

class QuestionLoadingWidget extends StatefulWidget {
  final QuestionConfiguration questionConfiguration;
  final String? sectionid;
  final bool isTestExam;

  final String? examId;

  const QuestionLoadingWidget(
      {Key? key,
      required this.questionConfiguration,
      this.isTestExam = false,
      this.sectionid,
      this.examId})
      : super(key: key);
  @override
  _QuestionLoadingWidgetState createState() => _QuestionLoadingWidgetState();
}

List<String> _myListItem = [
  'Going through all your attempts',
  'Figuring out your strength and weaknesses',
  'Finding best question to show now'
];

class _QuestionLoadingWidgetState extends State<QuestionLoadingWidget> {
  Api _api = locator<Api>();
  @override
  void initState() {
    // API Call Here.
    Future.delayed(Duration(milliseconds: 2000), () {
      if (widget.isTestExam) {
        fetchQuestionsBasedOnExam(widget.examId!).then((value) {
          if (value != null) {
            Get.offAll(
              () => ExamScreen(
                examQuestionList: value,
                questionConfiguration: widget.questionConfiguration,
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: 'Failed to Get questions. Try Again Later',
                toastLength: Toast.LENGTH_LONG);
            Get.to(() => MainTabs());
          }
        });
      } else {
        fetchQuestions().then((value) {
          if (value != null) {
            Get.offAll(
              () => ExamScreen(
                examQuestionList: value,
                questionConfiguration: widget.questionConfiguration,
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: 'Failed to Get questions. Try Again Later',
                toastLength: Toast.LENGTH_LONG);
            Get.to(() => MainTabs());
          }
        });
      }
    });
    super.initState();
  }

  // call API and fetch questions

  Future<QuestionList?> fetchQuestions() async {
    // Build Query Parameters from Questions
    Map<String, dynamic> parameters =
        QueryFilterHelpers.returnQueryFilterForQuestion(
      selectedSubjects: widget.questionConfiguration.subjects,
      selectedChapters: widget.questionConfiguration.chapters,
      years: widget.questionConfiguration.selectedYears,
      totalQuestions: widget.questionConfiguration.totalQuestion,
    );

    try {
      Result myList =
          await _api.getListOfQuestions(queryParameters: parameters);

      final questionList =
          myList.questionAnswer!.map((qsnAns) => qsnAns.question).toList();
      if (questionList.isEmpty) {
        return null;
      }

        final nonNullableQuestions = questionList.whereType<Question>().toList();

      return QuestionList(nonNullableQuestions);
    } catch (err) {
      printLog(err);
      return null;
    }
  }

  Future<QuestionList?> fetchQuestionsBasedOnExam(String examId) async {
    // Build Query Parameters from Questions
    // Map<String, dynamic> parameters = {
    //   "extractedFrom": examName
    // };
    try {
      QuestionList myList = await _api.getQuestionBasedOnExam(examId: examId);
      print('list is $myList');

      print(myList.questions.length);
      return myList;
    } catch (err) {
      printLog(err);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              SpinKitThreeBounce(
                color: Theme.of(context).colorScheme.secondary,
                size: 30.0,
                duration: Duration(milliseconds: 1000),
              ),
              SizedBox(
                height: 20,
              ),
              // AnimatedList(itemBuilder: (context, index, animation) {
              //   return AutoSizeText(_myListItem[index]);
              // })
              DelayedDisplay(
                delay: Duration(milliseconds: 1000),
                child: AutoSizeText(
                  _myListItem[0],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 2000),
                child: AutoSizeText(
                  _myListItem[1],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),

              DelayedDisplay(
                delay: Duration(milliseconds: 3000),
                child: AutoSizeText(
                  _myListItem[2],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
