// ignore_for_file: unnecessary_null_comparison

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:med_prep/helpers/answer_logger.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';
import '../../../common/tools.dart';
import '../../../enums/answer_state.dart';
import '../../../enums/correct_answer.dart';
import '../../../models/question.dart';
import '../../../models/question_stat.dart';
import '../../../models/test_result.dart';
import '../../../services/api_service.dart';
import '../../../locator.dart';
// import '../../widgets/workout/floating_question_modal.dart';
import '../../widgets/workout/option_container.dart';
import '../../widgets/workout/option_container_viewmodel.dart';
import '../../widgets/workout/question_configuration.dart';
import '../report/report_screen.dart';
import '../result/result_screen.dart';

class ExamScreen extends StatefulWidget {
  // List of Question pushed from loading screen - when fetching of question is complete.
  final QuestionList examQuestionList;

  // Question Configuration which is passed
  // which define exam mode, timeInMinute, totalQuestions, difficulty, selectedYears, subjects
  final QuestionConfiguration questionConfiguration;

  ExamScreen({
    Key? key,
    required this.examQuestionList,
    required this.questionConfiguration,
  }) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<ExamScreen> {
  Api _api = locator<Api>();
  late QuestionStat? currentQuestionStat;
  // Question no. That is Currently Showing in the screen
  int currentQuestionNumber = 1;
  // Total Number of Question from previous screen
  int totalQuestionNumber = 0;

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

  // Answer is Submitted
  // ignore: todo
  // TODO: Need to send POST request to /userQuestionLogs
  bool isSubmitted = false;

  // This is defined to maintain state between exam mode and user mode
  bool isSimulateTest = true;

  // Time Based on Question from question count * 1.5 - if is passed through
  // question configuration it should not replaced.
  int timeBasedOnQuestion = 0;

  // Current Question based on passing index to list of questions.
  Question getCurrentQuestion() {
    return widget.examQuestionList.questions[currentQuestionNumber - 1];
  }

  // void startTimer() {
  // Start the periodic timer which prints something every 1 seconds
  // Timer.periodic(new Duration(seconds: 1), (time) {
  //   print('Something ${time.tick}');
  // });
  // }

  // Timer Controller for maintaing time state.
  late TimerController _timerController;

  // Log every question attempt of user
  late AnswerLogger answerLogger;

  Duration timeToAnswerQuestion = Duration(seconds: 0);

  void timeListener(Duration d) {
    // Here we will have elapsed tim
    // timeToAnswerQuestion =
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _timerController = TimerController(this);
    // startTimer();

    // _timerController.addListener(timeListener);

    answerLogger = AnswerLogger();

    // Total number of question
    totalQuestionNumber = widget.examQuestionList.questions.length;

    // Exam mode or user Mode
    isSimulateTest = widget.questionConfiguration.isSimulateTest;

    // If it is practice mode - calculate - 1.5min for each question
    if (!isSimulateTest) {
      timeBasedOnQuestion = (totalQuestionNumber * 1.5).floor();
    }

    if (widget.questionConfiguration.isSimulateTest) {
      initalTime = widget.questionConfiguration.timeInMinute;
    }

    buildListOfAnswerState();
    // _timerController.start(
    //     startFrom: Duration(minutes: 10));

    super.initState();
  }

  // Build list of question state - initially: AnswerState.NotDefined
  buildListOfAnswerState() {
    answerState =
        List.generate(widget.examQuestionList.questions.length, (index) {
      return AnswerState.NotDefiend;
    });
  }

  Future<Future> _onWillPop() async {
    return showModalBottomSheet(
      context: context,
      builder: (context) => OptionContainer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        await _onWillPop();
      },
      child:
          Consumer<OptionContainerViewModel>(builder: (context, model, child) {
        model.initialize();
        return Scaffold(
          backgroundColor: model.lightMode ? Colors.white : Colors.black,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                                color: model.lightMode
                                    ? Colors.black
                                    : Colors.white,
                              )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 10),
                            child:
                                // true
                                //     ?
                                IconButton(
                              color: model.lightMode
                                  ? Colors.black26
                                  : Colors.white,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => OptionContainer(),
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.alignRight,
                              ),
                            )
                            // : ElevatedButton(
                            //     onPressed: () {
                            //       Get.offAll(MainTabs());
                            //     },
                            //     child: AutoSizeText('Exit'),
                            //   ),
                            ),
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
                                  'Error While Fetching Question. Check you internet connection. Try again later.',
                                  style: TextStyle(
                                    color: model.lightMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                    Color(0xff249DD8),
                                  )),
                                  onPressed: () {
                                    // fetchRandomQuestion();
                                  },
                                  child: AutoSizeText(
                                    'Refresh',
                                    style: TextStyle(
                                      color: model.lightMode
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onLongPress: () async {
                              await Clipboard.setData(ClipboardData(
                                  text: getCurrentQuestion().id!));
                              await Fluttertoast.showToast(
                                backgroundColor: Colors.black45,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                msg: 'Question Id copied to clipboard',
                              );
                            },
                            child: Center(
                              child: showQuestionUsingHTMLParser(
                                  question: getCurrentQuestion(),
                                  context: context,
                                  model: model),
                            ),
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
                            getCurrentQuestion().chapter!,
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
                          child: SimpleTimer(
                            controller: _timerController,
                            valueListener: timeListener,

                            duration: Duration(
                              minutes: isSimulateTest
                                  ? widget.questionConfiguration.timeInMinute
                                  : timeBasedOnQuestion,
                            ),
                            // timerStyle: TimerStyle.expanding_sector,
                            displayProgressIndicator: true,
                            progressTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  model.lightMode ? Colors.black : Colors.white,
                            ),
                            progressIndicatorColor:
                                Theme.of(context).colorScheme.secondary,
                            backgroundColor: model.lightMode
                                ? Colors.black.withOpacity(0.1)
                                : Colors.white30,
                          ),
                        ),
                      ),

                      ///This is the main things to done
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
                                    // Log the answer attempt by user
                                    answerLogger.postUserStat(
                                      timeTaken: 5,
                                      question: getCurrentQuestion().id!,
                                      selectedAnswer: answerEnumToString(
                                        answerOption: selectedAnswer,
                                      ),
                                    );

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
                                  isLastQuestion
                                      ? 'Get Result'
                                      : 'Submit Answer',
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
                                        // debugger();
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
                                              answerState[
                                                  currentQuestionNumber -
                                                      1] = AnswerState.Correct;
                                            } else {
                                              answerState[
                                                  currentQuestionNumber -
                                                      1] = AnswerState.Wrong;
                                            }

                                            currentQuestionNumber++;
                                            // Move to next question - disabled the button
                                            // Answer is not submitted in new question
                                            isSubmitted = false;

                                            currentQuestionStat = null;

                                            selectedAnswer = null;
                                          });
                                        } else {
                                          // debugger();
                                          setState(() {
                                            // Submit Button is Pressed

                                            isSubmitted = true;

                                            Tools.showLoadingModal();

                                            _api
                                                .getQuestionStat(
                                                    getCurrentQuestion().id!)
                                                .then((value) {
                                              Tools.dismissLoadingModal();
                                              setState(() {
                                                currentQuestionStat = value!;
                                              });
                                            });

                                            // Log the answer attempt by user
                                            answerLogger.postUserStat(
                                              timeTaken: 5,
                                              question:
                                                  getCurrentQuestion().id!,
                                              selectedAnswer:
                                                  answerEnumToString(
                                                answerOption: selectedAnswer,
                                              ),
                                            );

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
                                  isSubmitted
                                      ? 'Next Question'
                                      : 'Submit Answer',
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
      }),
    );
  }

  Widget showQuestionUsingHTMLParser(
      {Question? question,
      BuildContext? context,
      OptionContainerViewModel? model}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Html(
            data: question!.question,
            style: {
              "p": Style(
                fontWeight: FontWeight.bold,
                fontSize: FontSize(model!.fontSize() + 2.0),
                wordSpacing: 1,
                color: model.lightMode
                    ? Colors.black.withOpacity(0.8)
                    : Colors.white.withOpacity(0.9),
              )
            },
            //!!! Rohan 
            // onImageTap: (image, A, B, C) {
            //   showFloatingModalBottomSheet(
            //     context: context!,
            //     builder: (context, _) => Container(
            //       color: Colors.white,
            //       height: MediaQuery.of(context).size.height / 2,
            //       child: PhotoView(
            //         backgroundDecoration: BoxDecoration(color: Colors.white),
            //         imageProvider: CachedNetworkImageProvider(image),
            //       ),
            //     ),
            //   );
            // },
            //!!! Rohan
          ),
          // HtmlWidget(
          //   question.question,
          //   textStyle: TextStyle(
          //     fontSize: model.fontSize() + 2.0,
          //   ),
          //   customStylesBuilder: (e) {
          //     print('Build question part');

          //     return {
          //       'color': 'black',
          //       'font-weight': 'normal'
          //     };
          //   },
          // ),
          SizedBox(
            height: 10,
          ),

          // For Option A
          InkWell(
            onTap: !isSubmitted
                ? () {
                    setState(() {
                      selectedAnswer = AnswerOption.A;
                    });
                  }
                : null,
            child: Stack(
              children: [
                !isSimulateTest
                    ? isSubmitted
                        ? selectedAnswer == AnswerOption.A ||
                                question.correctAnswer == AnswerOption.A
                            ? Positioned(
                                // right: 4,
                                // top: 3,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context!).size.width,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     color: Colors.black.withOpacity(0.4)),
                                    color: getMessageString(
                                              question: question,
                                              selectedAnswer: selectedAnswer,
                                              buildingFor: AnswerOption.A,
                                            ) ==
                                            "You Marked"
                                        ? Colors.red
                                        : (getMessageString(
                                                  question: question,
                                                  selectedAnswer:
                                                      selectedAnswer,
                                                  buildingFor: AnswerOption.A,
                                                ) ==
                                                "You Missed"
                                            ? Colors.green
                                            : (getMessageString(
                                                      question: question,
                                                      selectedAnswer:
                                                          selectedAnswer,
                                                      buildingFor:
                                                          AnswerOption.A,
                                                    ) ==
                                                    "Correct"
                                                ? Colors.green
                                                : Colors.transparent)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // child: AutoSizeText(
                                  //   getMessageString(
                                  //     question: question,
                                  //     selectedAnswer: selectedAnswer,
                                  //     buildingFor: AnswerOption.A,
                                  //   ),
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ),
                              )
                            : Container()
                        : Container()
                    : Container(),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: selectedAnswer == AnswerOption.A
                        ? Border.all(
                            color: Theme.of(context!).colorScheme.secondary,
                            width: 1.2,
                            style: BorderStyle.solid,
                          )
                        : null,
                    color: Theme.of(context!)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                  child: Container(
                    height: 20,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 20,
                            width: 20,
                            color: selectedAnswer == AnswerOption.A
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'A',
                                style: TextStyle(
                                  color: selectedAnswer == AnswerOption.A
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: selectedAnswer == AnswerOption.A
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            question.optionA!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                                  model.lightMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: model.fontSize(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                currentQuestionStat != null
                    ? LayoutBuilder(builder: (context, constraints) {
                        print(constraints.maxWidth);
                        int total = currentQuestionStat!.optionA! +
                            currentQuestionStat!.optionB! +
                            currentQuestionStat!.optionC! +
                            currentQuestionStat!.optionD!;

                        if (total == 0) {
                          total = 1;
                        }
                        return Container(
                            height: 60,
                            width: ((currentQuestionStat!.optionA)! / total) *
                                constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.2),
                            ));
                      })
                    : Container(),
              ],
            ),
          ),

          SizedBox(
            height: 10,
          ),
          // Option B
          InkWell(
            onTap: !isSubmitted
                ? () {
                    setState(() {
                      selectedAnswer = AnswerOption.B;
                    });
                  }
                : null,
            child: Stack(
              children: [
                !isSimulateTest
                    ? isSubmitted
                        ? selectedAnswer == AnswerOption.B ||
                                question.correctAnswer == AnswerOption.B
                            ? Positioned(
                                // right: 4,
                                // top: 3,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     color: Colors.black.withOpacity(0.4)),
                                    color: getMessageString(
                                              question: question,
                                              selectedAnswer: selectedAnswer,
                                              buildingFor: AnswerOption.B,
                                            ) ==
                                            "You Marked"
                                        ? Colors.red
                                        : (getMessageString(
                                                  question: question,
                                                  selectedAnswer:
                                                      selectedAnswer,
                                                  buildingFor: AnswerOption.B,
                                                ) ==
                                                "You Missed"
                                            ? Colors.green
                                            : (getMessageString(
                                                      question: question,
                                                      selectedAnswer:
                                                          selectedAnswer,
                                                      buildingFor:
                                                          AnswerOption.B,
                                                    ) ==
                                                    "Correct"
                                                ? Colors.green
                                                : Colors.transparent)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // child: AutoSizeText(
                                  //   getMessageString(
                                  //     question: question,
                                  //     selectedAnswer: selectedAnswer,
                                  //     buildingFor: AnswerOption.B,
                                  //   ),
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ),
                              )
                            : Container()
                        : Container()
                    : Container(),
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: selectedAnswer == AnswerOption.B
                          ? Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.2,
                              style: BorderStyle.solid,
                            )
                          : null,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ),
                    child: Container(
                      height: 20,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: selectedAnswer == AnswerOption.B
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white,
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'B',
                                  style: TextStyle(
                                    color: selectedAnswer == AnswerOption.B
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: selectedAnswer == AnswerOption.B
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              question.optionB!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: model.lightMode
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: model.fontSize(),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                currentQuestionStat != null
                    ? LayoutBuilder(builder: (context, constraints) {
                        print(constraints.maxWidth);

                        int total = currentQuestionStat!.optionA! +
                            currentQuestionStat!.optionB! +
                            currentQuestionStat!.optionC! +
                            currentQuestionStat!.optionD!;

                        if (total == 0) {
                          total = 1;
                        }

                        return Container(
                            height: 60,
                            width: ((currentQuestionStat!.optionB)! / total) *
                                constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.2),
                            ));
                      })
                    : Container(),
              ],
            ),
          ),

          SizedBox(
            height: 10,
          ),
          // Option C
          InkWell(
            onTap: !isSubmitted
                ? () {
                    setState(() {
                      selectedAnswer = AnswerOption.C;
                    });
                  }
                : null,
            child: Stack(
              children: [
                !isSimulateTest
                    ? isSubmitted
                        ? selectedAnswer == AnswerOption.C ||
                                question.correctAnswer == AnswerOption.C
                            ? Positioned(
                                // right: 4,
                                // top: 3,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     color: Colors.black.withOpacity(0.4)),
                                    color: getMessageString(
                                              question: question,
                                              selectedAnswer: selectedAnswer,
                                              buildingFor: AnswerOption.C,
                                            ) ==
                                            "You Marked"
                                        ? Colors.red
                                        : (getMessageString(
                                                  question: question,
                                                  selectedAnswer:
                                                      selectedAnswer,
                                                  buildingFor: AnswerOption.C,
                                                ) ==
                                                "You Missed"
                                            ? Colors.green
                                            : (getMessageString(
                                                      question: question,
                                                      selectedAnswer:
                                                          selectedAnswer,
                                                      buildingFor:
                                                          AnswerOption.C,
                                                    ) ==
                                                    "Correct"
                                                ? Colors.green
                                                : Colors.transparent)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // child: AutoSizeText(
                                  //   getMessageString(
                                  //     question: question,
                                  //     selectedAnswer: selectedAnswer,
                                  //     buildingFor: AnswerOption.C,
                                  //   ),
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ),
                              )
                            : Container()
                        : Container()
                    : Container(),
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: selectedAnswer == AnswerOption.C
                          ? Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1.2,
                              style: BorderStyle.solid,
                            )
                          : null,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ),
                    child: Container(
                      height: 20,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 20,
                              width: 20,
                              color: selectedAnswer == AnswerOption.C
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white,
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  'C',
                                  style: TextStyle(
                                    color: selectedAnswer == AnswerOption.C
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: selectedAnswer == AnswerOption.C
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              question.optionC!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: model.lightMode
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: model.fontSize(),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                currentQuestionStat != null
                    ? LayoutBuilder(builder: (context, constraints) {
                        print(constraints.maxWidth);

                        int total = currentQuestionStat!.optionA! +
                            currentQuestionStat!.optionB! +
                            currentQuestionStat!.optionC! +
                            currentQuestionStat!.optionD!;

                        if (total == 0) {
                          total = 1;
                        }
                        return Container(
                            height: 60,
                            width: ((currentQuestionStat!.optionC)! / total) *
                                constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.2),
                            ));
                      })
                    : Container(),
              ],
            ),
          ),

          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: !isSubmitted
                ? () {
                    setState(() {
                      selectedAnswer = AnswerOption.D;
                    });
                  }
                : null,
            child: Stack(
              children: [
                !isSimulateTest
                    ? isSubmitted
                        ? selectedAnswer == AnswerOption.D ||
                                question.correctAnswer == AnswerOption.D
                            ? Positioned(
                                // right: 4,
                                // top: 3,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //     color: Colors.black.withOpacity(0.4)),
                                    color: getMessageString(
                                              question: question,
                                              selectedAnswer: selectedAnswer,
                                              buildingFor: AnswerOption.D,
                                            ) ==
                                            "You Marked"
                                        ? Colors.red
                                        : (getMessageString(
                                                  question: question,
                                                  selectedAnswer:
                                                      selectedAnswer,
                                                  buildingFor: AnswerOption.D,
                                                ) ==
                                                "You Missed"
                                            ? Colors.green
                                            : (getMessageString(
                                                      question: question,
                                                      selectedAnswer:
                                                          selectedAnswer,
                                                      buildingFor:
                                                          AnswerOption.D,
                                                    ) ==
                                                    "Correct"
                                                ? Colors.green
                                                : Colors.transparent)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // child: AutoSizeText(
                                  //   getMessageString(
                                  //     question: question,
                                  //     selectedAnswer: selectedAnswer,
                                  //     buildingFor: AnswerOption.D,
                                  //   ),
                                  //   style: TextStyle(
                                  //     color: Colors.red,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ),
                              )
                            : Container()
                        : Container()
                    : Container(),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: selectedAnswer == AnswerOption.D
                        ? Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1.2,
                            style: BorderStyle.solid,
                          )
                        : null,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.2),
                  ),
                  child: Container(
                    height: 20,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 20,
                            width: 20,
                            color: selectedAnswer == AnswerOption.D
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'D',
                                style: TextStyle(
                                  color: selectedAnswer == AnswerOption.D
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: selectedAnswer == AnswerOption.D
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            question.optionD!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color:
                                  model.lightMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: model.fontSize(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                currentQuestionStat != null
                    ? LayoutBuilder(builder: (context, constraints) {
                        print(constraints.maxWidth);

                        int total = currentQuestionStat!.optionA! +
                            currentQuestionStat!.optionB! +
                            currentQuestionStat!.optionC! +
                            currentQuestionStat!.optionD!;

                        if (total == 0) {
                          total = 1;
                        }
                        return Container(
                            height: 60,
                            width: ((currentQuestionStat!.optionD)! / total) *
                                constraints.maxWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.2),
                            ));
                      })
                    : Container(),
              ],
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                    model.lightMode ? Colors.white : Colors.black,
                  )),
                  onPressed: () {
                    // Take user to disussion section screen alogn with question id and actual question.
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: ReportScreen(
                                      questionId: getCurrentQuestion().id!,
                                      questionTitle:
                                          getCurrentQuestion().question!,
                                    ))),
                          );
                        });
                  },
                  child: Container(
                      child: AutoSizeText(
                    'Report',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: model.lightMode ? Colors.black : Colors.white,
                    ),
                  )))),

          !isSimulateTest
              ? isSubmitted
                  ? Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 40,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Card(
                        color: !model.lightMode ? Colors.black : Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 10,
                          ),
                          child: HtmlWidget(
                            question.explanation!,
                            textStyle: TextStyle(
                              fontSize: model.fontSize(),
                              letterSpacing: 0.5,
                              height: 1.3,
                              color:
                                  model.lightMode ? Colors.black : Colors.white,
                            ),
                            customStylesBuilder: (elm) {
                              if (elm.classes.contains('greenText')) {
                                return {
                                  'color': model.lightMode ? 'blue' : 'red',
                                  'font-weight': 'bold',
                                };
                              }

                              if (elm.localName == 'tbody') {
                                return {
                                  'border': '20px',
                                  'cellpadding': '20px'
                                };
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    )
                  : AutoSizeText('')
              : AutoSizeText(''),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _timerController.start();
  }

  String answerEnumToString({AnswerOption? answerOption}) {
    switch (answerOption) {
      case AnswerOption.A:
        return "A";
      case AnswerOption.B:
        return "B";
      case AnswerOption.C:
        return "C";
      case AnswerOption.D:
        return "D";
      case null:
    }
    return "A";
  }

  String getMessageString(
      {Question? question,
      AnswerOption? selectedAnswer,
      AnswerOption? buildingFor}) {
    // Selected Anser is Correct, and is also euqal to for option which is building
    if (selectedAnswer == question!.correctAnswer &&
        question.correctAnswer == buildingFor) {
      return 'Correct';
    }

    if (selectedAnswer != question.correctAnswer &&
        buildingFor == question.correctAnswer) {
      return 'You Missed';
    }

    if (selectedAnswer == buildingFor &&
        selectedAnswer != question.correctAnswer) {
      return 'You Marked';
    }
    return '';
  }
}
