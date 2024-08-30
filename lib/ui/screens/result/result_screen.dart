// ignore_for_file: unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../common/constants.dart';
import '../../../common/tools.dart';
import '../../../enums/answer_state.dart';
import '../../../models/question.dart';
import '../../../models/test_result.dart';
import '../../../tabbar.dart';
import '../user-stat/user_stat_screen.dart';

class ResultScreen extends StatefulWidget {
  final TestResult? testResult;
  const ResultScreen({
    Key? key,
    this.testResult,
  }) : super(key: key);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TabController _controller;

  int selectedIndex = 0;

  bool isResultSaved = false;

  late Map<AnswerState, int> myResultMap;

  // StorageService _storageService = locator<StorageService>();
// selected's value = 0. For default first item is open.
  int selected = 0; //attention
  @override
  void initState() {
    super.initState();

    myResultMap = getResult(widget.testResult!.answerState);

    printLog(widget.testResult!.answerState.length);
    printLog(widget.testResult!.questionList.questions.length);
  }

  Map<AnswerState, int> getResult(List<AnswerState> examAnswerState) {
    Map<AnswerState, int> resultMap = {};
    int correctAnswer = 0;
    int inCorrectAnswer = 0;
    int notAnsweredAnswer = 0;
    examAnswerState.forEach((answerState) {
      if (answerState == AnswerState.Correct) {
        correctAnswer++;
      } else if (answerState == AnswerState.Wrong) {
        inCorrectAnswer++;
      } else {
        notAnsweredAnswer++;
      }
    });
    resultMap = {
      AnswerState.Correct: correctAnswer,
      AnswerState.Wrong: inCorrectAnswer,
      AnswerState.NotDefiend: notAnsweredAnswer,
    };
    return resultMap;
  }

  @override
  Widget build(BuildContext context) {
    var totalAnswer = myResultMap[AnswerState.Correct]! +
        myResultMap[AnswerState.NotDefiend]! +
        myResultMap[AnswerState.Wrong]!;
    final List<ChartData> chartData = [
      ChartData('Correct', _getPercentage(AnswerState.Correct)),
      ChartData('Wrong', _getPercentage(AnswerState.Wrong)),
      ChartData('Skipped', _getPercentage(AnswerState.NotDefiend)),
    ];
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          // toolbarHeight: 89,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.offAll(() => MainTabs());
                },
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              AutoSizeText(
                'Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //  actions: [
          //    InkWell(
          //              onTap: () {
          //                Get.offAll(() => MainTabs());
          //              },
          //              child: Container(
          //                padding: EdgeInsets.only(top: 5),
          //                child: Icon(
          //                  Icons.arrow_back_ios,
          //                  color: Colors.white,
          //                  size: 28,
          //                ),
          //              ),
          //            ),
          //            Padding(
          //              child: AutoSizeText(
          //                'Results',
          //                style: TextStyle(
          //                    fontSize: 27,
          //                    fontWeight: FontWeight.bold,
          //                    color:Colors.white,),
          //              ),
          //              padding: EdgeInsets.only(
          //                top: 5,
          //                left: 10,
          //                bottom: 0,
          //                right: 10,
          //              ),
          //            ),

          //     //  Container(
          //     //    alignment: Alignment.centerLeft,
          //     //    child: Row(
          //     //      mainAxisAlignment: MainAxisAlignment.start,
          //     //      children: [

          //     //        ],
          //     //    ),
          //     //  ),
          //     SizedBox(height: 10),

          //  ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: selectedIndex,
                    child: Container(
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: TabBar(
                                // labelPadding: EdgeInsets.symmetric(horizontal: 15.0),
                                unselectedLabelColor: const Color(0xffBDBDBD),
                                labelColor:
                                    Theme.of(context).colorScheme.secondary,
                                indicatorColor:
                                    Theme.of(context).colorScheme.secondary,
                                // isScrollable: true,
                                padding: EdgeInsets.only(top: 25.0),
                                labelStyle: GoogleFonts.nunito(
                                    fontSize: 18.0,
                                    height: 1.0,
                                    fontWeight: FontWeight.w600),
                                controller: _controller,

                                tabs: [
                                  Tab(
                                    child: AutoSizeText(
                                      'Analysis',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        height: 1.36,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: AutoSizeText(
                                      'Solution',
                                      style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        height: 1.36,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   child: Center(
                                  //     child: AutoSizeText(
                                  //       "Analysis",
                                  //       style: TextStyle(
                                  //         color: selectedIndex == 0
                                  //             ? Color(0xff333333)
                                  //             : Colors.black,
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w600,
                                  //       ),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   height: 40,
                                  //   child: Center(
                                  //     child: AutoSizeText(
                                  //       "Solution",
                                  //       style: TextStyle(
                                  //         color: selectedIndex == 0
                                  //             ? Color(0xff333333)
                                  //             : Colors.black,
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w600,
                                  //         fontFamily: "SFProRounded",
                                  //       ),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TabBarView(
                                  controller: _controller,
                                  children: [
                                    // Analysis
                                    SingleChildScrollView(
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.check_outlined,
                                                  size: 25,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                              SizedBox(
                                                width: 14.0,
                                              ),
                                              AutoSizeText(
                                                'Test Completed!',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff333333)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Card(
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.8,
                                                child: ListView(
                                                  children: [
                                                    ListTile(
                                                      title: AutoSizeText(
                                                        'Correct Answer ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff333333)),
                                                      ),
                                                      trailing: AutoSizeText(
                                                        "${myResultMap[AnswerState.Correct]} / $totalAnswer",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: AutoSizeText(
                                                        'Wrong Answer',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff333333),
                                                        ),
                                                      ),
                                                      trailing: AutoSizeText(
                                                        "${myResultMap[AnswerState.Wrong]} / $totalAnswer",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: AutoSizeText(
                                                        'Skipped',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff333333)),
                                                      ),
                                                      trailing: AutoSizeText(
                                                        "${myResultMap[AnswerState.NotDefiend]} / $totalAnswer",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: AutoSizeText(
                                                        'Total Time',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff333333)),
                                                      ),
                                                      trailing: AutoSizeText(
                                                        "2m 20s",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: AutoSizeText(
                                                        'Average Time per Qsn',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xff333333),
                                                        ),
                                                      ),
                                                      trailing: AutoSizeText(
                                                        "20 sec",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Card(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            // color: Colors.lightBlue[100],
                                            child: Container(
                                              height: 250,
                                              child: SfCircularChart(
                                                  palette: <Color>[
                                                    Color(0xff709fb0),
                                                    Colors.red[300]!,
                                                    Colors.yellow,
                                                    Colors.grey
                                                  ],
                                                  legend: Legend(
                                                      isVisible: true,
                                                      textStyle: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 17)),
                                                  series: <CircularSeries>[
                                                    PieSeries<ChartData,
                                                            String>(
                                                        dataSource: chartData,
                                                        pointColorMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.color,
                                                        xValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.x,
                                                        yValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.y,
                                                        dataLabelSettings:
                                                            DataLabelSettings(
                                                          isVisible: true,
                                                          borderColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          textStyle: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ))
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    // Solution
                                    // Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //           horizontal: 15,
                                    //         ),
                                    //         child: ListView.separated(
                                    //           itemBuilder: (context, index) {
                                    //             return ExpansionInfo(
                                    //               shownWidget: Row(
                                    //                 children: [
                                    //                   Container(
                                    //                     child: widget.testResult
                                    //                                     .answerState[
                                    //                                 index] ==
                                    //                             AnswerState.Wrong
                                    //                         ? Center(
                                    //                             child: Icon(
                                    //                               FontAwesomeIcons
                                    //                                   .times,
                                    //                               color: Colors.red,
                                    //                             ),
                                    //                           )
                                    //                         : Center(
                                    //                             child: Icon(
                                    //                               FontAwesomeIcons
                                    //                                   .check,
                                    //                               color:
                                    //                                   Colors.green,
                                    //                             ),
                                    //                           ),
                                    //                   ),
                                    //                   SizedBox(
                                    //                     width: 15,
                                    //                   ),
                                    //                   Container(
                                    //                     width:
                                    //                         MediaQuery.of(context)
                                    //                                 .size
                                    //                                 .width *
                                    //                             0.70,
                                    //                     // color: widget.testResult
                                    //                     //             .answerState[index] ==
                                    //                     //         AnswerState.Wrong
                                    //                     //     ? Colors.red
                                    //                     //     : Color(0xff333333),
                                    //                     child: HtmlWidget(
                                    //                       widget
                                    //                           .testResult
                                    //                           .questionList
                                    //                           .questions[index]
                                    //                           .question,
                                    //                       customStylesBuilder: (e) {
                                    //                         return {
                                    //                           'color': 'black',
                                    //                           'font-size': '18px',
                                    //                           'font-weight':
                                    //                               'normal'
                                    //                         };
                                    //                       },
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //               title: '',
                                    //               children: [
                                    //                 HtmlWidget(
                                    //                   widget
                                    //                       .testResult
                                    //                       .questionList
                                    //                       .questions[index]
                                    //                       .question,
                                    //                   customStylesBuilder: (e) {
                                    //                     return {
                                    //                       'color': 'black',
                                    //                       'font-size': '18px',
                                    //                       'font-weight': 'normal'
                                    //                     };
                                    //                   },
                                    //                 ),
                                    //                 AutoSizeText(
                                    //                   'A. ${widget.testResult.questionList.questions[index].optionA}',
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //                 AutoSizeText(
                                    //                   'B. ${widget.testResult.questionList.questions[index].optionB}',
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //                 AutoSizeText(
                                    //                   'C. ${widget.testResult.questionList.questions[index].optionC}',
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //                 AutoSizeText(
                                    //                   'D. ${widget.testResult.questionList.questions[index].optionD}',
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //                 HtmlWidget(
                                    //                   widget
                                    //                       .testResult
                                    //                       .questionList
                                    //                       .questions[index]
                                    //                       .explanation,
                                    //                   customStylesBuilder: (elm) {
                                    //                     if (elm.classes.contains(
                                    //                         'greenText')) {
                                    //                       return {
                                    //                         'color': 'blue',
                                    //                         'font-weight': 'bold',
                                    //                       };
                                    //                     }
                                    //                     return null;
                                    //                   },
                                    //                 )
                                    //               ],
                                    //             );
                                    //           },
                                    //           separatorBuilder: (context, index) {
                                    //             return Divider();
                                    //           },
                                    //           itemCount: (widget
                                    //                   .testResult
                                    //                   .questionList
                                    //                   .questions
                                    //                   .length -
                                    //               1),
                                    //         ),
                                    //       ),
                                    SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: widget.testResult!
                                            .questionList.questions.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              // color: Colors.lightBlue[100],
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                    child: Container(
                                                      child: topCardWidget(
                                                          question: widget
                                                              .testResult!
                                                              .questionList
                                                              .questions[index],
                                                          answerState: widget
                                                                  .testResult!
                                                                  .answerState[
                                                              index]),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 40,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0),
                                                      child: OutlinedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty.all<
                                                                    Color>(Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                side: BorderSide
                                                                    .none)),
                                                          ),
                                                          child: AutoSizeText(
                                                            'View Detail Answer',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () async {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  true,
                                                              useSafeArea: true,
                                                              // barrierColor:
                                                              //     Colors.blue,

                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Dialog(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        15.0),
                                                                  ),
                                                                ),
                                                                // elevation: 5.0,
                                                                insetPadding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            20.0,
                                                                        right:
                                                                            20.0,
                                                                        bottom:
                                                                            10.0),

                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    bottomCardWidget(
                                                                        question:
                                                                            widget.testResult!.questionList.questions[
                                                                                index],
                                                                        answerState: widget
                                                                            .testResult!
                                                                            .answerState[index]),
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          //return false;
                                                                        },
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Close',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                      // Card(
                                                      //   child: bottomCardWidget(
                                                      //       question: widget
                                                      //           .testResult
                                                      //           .questionList
                                                      //           .questions[index],
                                                      //       answerState: widget.testResult
                                                      //           .answerState[index]),
                                                      // ),
                                                      ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 30.0),
                            //   child: TextButton(
                            //     onPressed: isResultSaved
                            //         ? null
                            //         : () async {
                            //             // Get data from shared prefs first

                            //             try {
                            //               final jsonResultList =
                            //                   await _storageService
                            //                       .getDataFromSharedPrefs(
                            //                           key: CACHED_RESULTS);

                            //               if (jsonResultList == null) {
                            //                 await _storageService
                            //                     .saveDataToSharedPrefs(
                            //                         key: CACHED_RESULTS,
                            //                         data: json.encode([]));
                            //               } else {}

                            //               TestResultList testList =
                            //                   TestResultList.fromJson(
                            //                       json.decode(jsonResultList));

                            //               List<TestResult> testResults =
                            //                   testList.testResults;

                            //               testResults.add(TestResult.fromJson(
                            //                   widget.testResult.toMap()));

                            //               TestResultList listToSave =
                            //                   TestResultList(testResults);

                            //               await _storageService
                            //                   .saveDataToSharedPrefs(
                            //                 data:
                            //                     jsonEncode(listToSave.toList()),
                            //                 key: CACHED_RESULTS,
                            //               );
                            //               setState(() {
                            //                 isResultSaved = true;
                            //               });
                            //               Tools.showSuccessToast(
                            //                   'Result saved successfully.');
                            //             } catch (err) {
                            //               print(err);
                            //               // debugger();
                            //               Tools.showErrorToast(
                            //                   'Failed to Save Results');
                            //             }
                            //           },
                            //     style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all<
                            //               Color>(
                            //           Theme.of(context).colorScheme.primary),
                            //       // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal:20.0)
                            //       // )
                            //       //                         textStyle:MaterialStateProperty.all<TextStyle>( TextStyle(
                            //       // fontWeight: FontWeight.w500,
                            //       // fontSize: 10,
                            //       // color: Color(0xff333333),
                            //       // )),
                            //     ),
                            //     child: AutoSizeText(
                            //       'Save Result',
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 14,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // Helper Functions Related to result screen

  double _getPercentage(AnswerState answerState) {
    int totalQuestions = widget.testResult!.questionList.questions.length;

    return ((myResultMap[answerState]! / totalQuestions) * 100).floor() * 1.0;
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget({
    Question? question,
    AnswerState? answerState,
  }) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children: <Widget>[
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: HtmlWidget(
            question!.question!,
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff333333),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  // color: Colors.white,
                  style: ButtonStyle(
                      // elevation:MaterialStateProperty.all<double>( 0.0),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: AutoSizeText(
                        "A: ${question.optionA}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: ElevatedButton(
                  // elevation: 0.0,
                  onPressed: () {},
                  // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  // color: Colors.white,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: AutoSizeText(
                        "B: ${question.optionB}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: ElevatedButton(
                  // elevation: 0.0,
                  onPressed: () {},
                  // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  // color: Colors.white,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: AutoSizeText(
                        "C: ${question.optionC}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: ElevatedButton(
                  // elevation: 0.0,
                  onPressed: () {},
                  // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(40.0),
                  // ),
                  // color: Colors.white,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: AutoSizeText(
                        "D: ${question.optionD}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: AutoSizeText(
                        'The correct answer is: ${Utils.answerEnumToString(answerOption: question.correctAnswer)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // ExpansionTile(
              //   // key: Key(selected.toString()), //attention
              //   initiallyExpanded: false, //attention
              //   //     initiallyExpanded: index == 0,
              //   iconColor: Colors.black,
              //   backgroundColor: Colors.white,
              //   // onExpansionChanged: ((newState) {
              //   //   if (newState)
              //   //     setState(() {
              //   //       Duration(seconds: 20000);
              //   //       selected = selected;
              //   //     });
              //   //   else
              //   //     setState(() {
              //   //       selected = -1;
              //   //     });
              //   // }),
              //   title: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       AutoSizeText('View Detail Answer '),
              //     ],
              //   ),
              //   children: [
              //     ListView.builder(
              //         // itemCount:
              //         //     widget.testResult.questionList.questions..length,
              //         itemBuilder: (context, index) {
              //       return bottomCardWidget(
              //         question: widget.testResult.questionList.questions[index],
              //         answerState: widget.testResult.answerState[index],
              //       );
              //     }),
              //     // Container(
              //     //   padding: EdgeInsets.symmetric(horizontal: 5.0),
              //     //   child: OutlinedButton(
              //     //     onPressed: () async {
              //     //       showDialog(
              //     //         barrierDismissible: true,
              //     //         context: context,
              //     //         builder: (context) => AlertDialog(
              //     //           shape: RoundedRectangleBorder(
              //     //             borderRadius: BorderRadius.all(
              //     //               Radius.circular(15.0),
              //     //             ),
              //     //           ),
              //     //           elevation: 5.0,
              //     //           // contentPadding: const EdgeInsets.only(
              //     //           //     left: 18.0, right: 18.0, top: 20.0, bottom: 10.0),
              //     //           content: Column(
              //     //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //             crossAxisAlignment: CrossAxisAlignment.center,
              //     //             mainAxisSize: MainAxisSize.min,
              //     //             children: <Widget>[
              //     //               ListView.builder(
              //     //                   physics: NeverScrollableScrollPhysics(),
              //     //                   shrinkWrap: true,
              //     //                   itemCount: widget
              //     //                       .testResult.questionList.questions.length,
              //     //                   itemBuilder: (context, index) {
              //     //                     return bottomCardWidget(
              //     //                         question: widget.testResult.questionList
              //     //                             .questions[index],
              //     //                         answerState: widget
              //     //                             .testResult.answerState[index]);
              //     //                   }),
              //     //               Container(
              //     //                 alignment: Alignment.center,
              //     //                 child: TextButton(
              //     //                   padding: const EdgeInsets.all(0.0),
              //     //                   onPressed: () {
              //     //                     Navigator.pop(context);
              //     //                     return false;
              //     //                   },
              //     //                   child: AutoSizeText(
              //     //                     'Close',
              //     //                   ),
              //     //                 ),
              //     //               ),
              //     //             ],
              //     //           ),
              //     //         ),
              //     //       );
              //     //       // await showDialog(
              //     //       //     context: (context),
              //     //       //     builder: (context) {
              //     //       //       return AlertDialog(
              //     //       //         title: ListView.builder(
              //     //       //             physics: NeverScrollableScrollPhysics(),
              //     //       //             shrinkWrap: true,
              //     //       //             itemCount: widget
              //     //       //                 .testResult.questionList.questions.length,
              //     //       //             itemBuilder: (context, index) {
              //     //       //               return bottomCardWidget(
              //     //       //                   question: widget.testResult.questionList
              //     //       //                       .questions[index],
              //     //       //                   answerState: widget
              //     //       //                       .testResult.answerState[index]);
              //     //       //             }),
              //     //       //       );
              //     //       //     });
              //     //     },
              //     //     style: ButtonStyle(
              //     //       backgroundColor:
              //     //           MaterialStateProperty.all<Color>(Colors.green),
              //     //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //     //           borderRadius: BorderRadius.circular(10.0),
              //     //           side: BorderSide.none)),
              //     //     ),
              //     //     child: AutoSizeText(
              //     //       'View Answer',
              //     //       style: TextStyle(color: Colors.white),
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ]),
          ),
        )
      ],
    );
  }

  Widget bottomCardWidget({
    Question? question,
    AnswerState? answerState,
  }) {
    return Container(
      height: 455,
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            HtmlWidget(
              // 'Paragraphs break up text into manageable chunks that are easily read and visually make it more appealing and less daunting. The word paragraph comes from the Latin word paragraphos, which is roughly translated to mean a short-stroke marking a break in sense. The term graph is Latin for writing. Paragraphs break up text into manageable chunks that are easily read and visually make it more appealing and less daunting. The word paragraph comes from the Latin word paragraphos, which is roughly translated to mean a short-stroke marking a break in sense. The term graph is Latin for writing. Paragraphs break up text into manageable chunks that are easily read and visually make it more appealing and less daunting. The word paragraph comes from the Latin word paragraphos, which is roughly translated to mean a short-stroke marking a break in sense. The term graph is Latin for writing. Paragraphs break up text into manageable chunks that are easily read and visually make it more appealing and less daunting. The word paragraph comes from the Latin word paragraphos, which is roughly translated to mean a short-stroke marking a break in sense. The term graph is Latin for writing.'
              question!.explanation!,
              textStyle: TextStyle(
                fontSize: 16,
                letterSpacing: 0.5,
                height: 1.3,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
