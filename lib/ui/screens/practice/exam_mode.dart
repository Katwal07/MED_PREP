// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';

import '../../../enums/answer_state.dart';
import '../../../enums/correct_answer.dart';
import '../../../locator.dart';
import '../../../models/question.dart';
import '../../../models/test_result.dart';
import '../../../services/api_service.dart';
import '../../widgets/workout/option_container.dart';
import '../../widgets/workout/option_container_viewmodel.dart';
import '../../widgets/workout/question_configuration.dart';
import '../result/result_screen.dart';

class ExamModeScreen extends StatefulWidget {
  // List of Question pushed from loading screen - when fetching of question is complete.
  final QuestionList examQuestionList;

  // Question Configuration which is passed
  // which define exam mode, timeInMinute, totalQuestions, difficulty, selectedYears, subjects
  final QuestionConfiguration questionConfiguration;

  ExamModeScreen({
    Key? key,
    required this.examQuestionList,
    required this.questionConfiguration,
  }) : super(key: key);

  @override
  _ExamModeScreenState createState() => _ExamModeScreenState();
}

class _ExamModeScreenState extends State<ExamModeScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<ExamModeScreen> {
  // For any kind of api request
  Api _api = locator<Api>();

// Question no. That is Currently Showing in the screen
  int currentQuestionNumber = 1;

  // Total Number of Question from previous screen
  int totalQuestionNumber = 1;
  //
  bool isLastQuestion = false;

  // Inital Time
  int initalTime = 0;

  // Array to store list of answer
  List<AnswerState> answerState = [];

  // Selected Answer means answer is selected, if not selected it is null
  late AnswerOption? selectedAnswer;

  // This property is not used yet
  bool hasError = false;

  // Timer Controller for maintaing time state.
  late TimerController _timerController;

  void timeListener(Duration d) {
    // Here we will have elapsed tim
    // timeToAnswerQuestion =
  }

  // Answer is Submitted

  // ignore: todo
  // TODO: Need to send POST request to /userQuestionLogs
  bool isSubmitted = false;

  // Current Question based on passing index to list of questions.
  Question getCurrentQuestion() {
    return widget.examQuestionList.questions[currentQuestionNumber - 1];
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(this);

    // Total number of question
    totalQuestionNumber = widget.examQuestionList.questions.length;

    initalTime = widget.questionConfiguration.timeInMinute;

    buildListOfAnswerState();
  }

  // Build list of question state - initially: AnswerState.NotDefined
  buildListOfAnswerState() {
    answerState =
        List.generate(widget.examQuestionList.questions.length, (index) {
      return AnswerState.NotDefiend;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OptionContainerViewModel>(builder: (context, model, child) {
      model.initialize();
      print(model.lightMode);
      return Scaffold(
        backgroundColor: model.lightMode ? Colors.white : Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: AutoSizeText(
                          widget.questionConfiguration.isSimulateTest
                              ? 'Exam Mode'
                              : 'User Mode',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                model.lightMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: AutoSizeText(
                            '$currentQuestionNumber of $totalQuestionNumber',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  model.lightMode ? Colors.black : Colors.white,
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            color:
                                model.lightMode ? Colors.black26 : Colors.white,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => OptionContainer(),
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.alignRight,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: hasError
                      ? Center(
                          child: Column(
                            children: [
                              AutoSizeText(
                                  'Error While Fetching Question. Check you internet connection. Try again later.'),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  Color(0xff249DD8),
                                )),
                                onPressed: () {
                                  // fetchRandomQuestion();
                                },
                                child: AutoSizeText(
                                  'Refresh',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(),
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: AutoSizeText(
                          getCurrentQuestion().section!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: SimpleTimer(
                          controller: _timerController,
                          valueListener: timeListener,

                          duration: Duration(
                              minutes:
                                  widget.questionConfiguration.timeInMinute),
                          // timerStyle: TimerStyle.expanding_sector,
                          displayProgressIndicator: true,
                          progressTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          progressIndicatorColor:
                              Theme.of(context).colorScheme.secondary,
                          backgroundColor: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: (currentQuestionNumber) == totalQuestionNumber
                          ? ElevatedButton(
                              onPressed: () {
                                // Handle Last Question
                                if (!isLastQuestion) {
                                  // set Answer state
                                  isSubmitted = true;
                                  if (selectedAnswer ==
                                      getCurrentQuestion().correctAnswer) {
                                    answerState.last = AnswerState.Correct;
                                  } else {
                                    answerState.last = AnswerState.Wrong;
                                  }
                                  print(selectedAnswer);
                                  print(getCurrentQuestion().correctAnswer);
                                  isSubmitted = true;

                                  isLastQuestion = true;
                                  return;
                                }

                                Get.offAll(() => ResultScreen(
                                    testResult: TestResult(
                                        questionList: widget.examQuestionList,
                                        answerState: answerState)));
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                Color(0xff249DD8),
                              )),
                              child: AutoSizeText(
                                isLastQuestion ? 'Get Result' : 'Submit Answer',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                Color(0xff249DD8),
                              )),
                              // There need to have selected answer
                              // else button is disabled.
                              onPressed: selectedAnswer != null
                                  ? () async {
                                      if (isSubmitted) {
                                        setState(() {
                                          _timerController.start();
                                          // ignore: todo
                                          //  TODO: Track this time - intial time.
                                          // timeToAnswerQuestion =
                                          //     _timerController
                                          //         .toStringDetails();

                                          print(_timerController);

                                          if (selectedAnswer ==
                                              getCurrentQuestion()
                                                  .correctAnswer) {
                                            answerState[currentQuestionNumber -
                                                1] = AnswerState.Correct;
                                          } else {
                                            answerState[currentQuestionNumber -
                                                1] = AnswerState.Wrong;
                                          }

                                          currentQuestionNumber++;
                                          // Move to next question - disabled the button
                                          // Answer is not submitted in new question
                                          isSubmitted = false;

                                          selectedAnswer = null;
                                        });
                                      } else {
                                        setState(() {
                                          // Submit Button is Pressed

                                          isSubmitted = true;

                                          // _api
                                          //     .getQuestionStat(
                                          //         getCurrentQuestion()
                                          //             .id)
                                          //     .then(
                                          //         (value) {
                                          //   setState(() {
                                          //     currentQuestionStat =
                                          //         value;
                                          //   });
                                          // });

                                          // Log the answer attempt by user
                                          // answerLogger
                                          //     .postUserStat(
                                          //   timeTaken: 5,
                                          //   question:
                                          //       getCurrentQuestion()
                                          //           .id,
                                          //   selectedAnswer:
                                          //       answerEnumToString(
                                          //     answerOption:
                                          //         selectedAnswer,
                                          //   ),
                                          // );

                                          // Pause the timer when answer is submitted and
                                          // next question is not yet started
                                          _timerController.pause();
                                          // ignore: todo
                                          // TODO: Track This time - calculate the Difference to get time taken for each question.
                                        });
                                      }
                                    }
                                  : null,
                              child: AutoSizeText(
                                isSubmitted ? 'Next Question' : 'Submit Answer',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // ignore: todo
    // TODO: implement afterFirstLayout
  }
}
