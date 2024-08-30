import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../locator.dart';
import '../../../models/exam.dart';
import '../../../services/api_service.dart';
import '../../widgets/workout/question_configuration.dart';
import '../../widgets/workout/question_loading_widget.dart';

class MyTestScreen extends StatefulWidget {
  @override
  _MyTestScreenState createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  Api _api = locator<Api>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<ExamModel> fetchExams = <ExamModel>[];
  late ScrollController _controller;

  int totalExams = 0;

  int page = 1; // Initial Page Number

  List<ExamModel> examList = <ExamModel>[];

  Future<void> getExams() async {
    final examPaginated = await _api.getAllExams(page: page);

    totalExams = examPaginated.result!;

    setState(() {
      examList = examList
        ..addAll(
          examPaginated.exams!.exams,
        );
    });
  }

  _onRefresh() async {
    HapticFeedback.mediumImpact();
  }

  @override
  void initState() {
    super.initState();

    getExams();

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _refreshController.refreshCompleted();
  }

  _scrollListener() async {
    // start loadMore when maxScrollExtent

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('Reached Max Extend');

      // We need more users
      page++;

      getExams().then((value) {
        if (examList.length >= totalExams) {
          _refreshController.loadNoData();
        } else {
          _refreshController.resetNoData();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: screenSize.width /
                      (2 / (screenSize.height / screenSize.width)),
                  child: Padding(
                    child: AutoSizeText(
                      'Available Tests',
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      bottom: 20,
                      right: 10,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[10],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      // scrollController: _controller,
                      enablePullUp: true,
                      enablePullDown: false,
                      child: examList.length == 0
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.grey[200]!,
                              child: ListView.builder(
                                controller: _controller,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ListTile(
                                      leading: Shimmer.fromColors(
                                        baseColor: Colors.green,
                                        highlightColor: Colors.green[200]!,
                                        child: Icon(
                                          FontAwesomeIcons.images,
                                          size: 17,
                                        ),
                                      ),
                                      title: Shimmer(
                                          enabled: true,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black,
                                              Colors.black54,
                                              /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                                            ],
                                          ),
                                          child: AutoSizeText(
                                            'Loading...............',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Shimmer(
                                            enabled: true,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black54,
                                                /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                                              ],
                                            ),
                                            child: AutoSizeText(
                                              'Loading...',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Shimmer(
                                            enabled: true,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black54,
                                                /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                                              ],
                                            ),
                                            child: AutoSizeText(
                                              'Loading...',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Shimmer(
                                        enabled: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.black54,
                                            /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          )),
                                          onPressed: () {},
                                          child: Shimmer(
                                            enabled: true,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.pink,
                                                Colors.black54,
                                                /*AppColours.appgradientfirstColour,
                                                    AppColours.appgradientsecondColour*/
                                              ],
                                            ),
                                            child: AutoSizeText('',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : ListView.builder(
                              controller: _controller,
                              itemCount: examList.length,
                              itemBuilder: (context, index) {
                                ExamModel eachExam = examList[index];

                                if (index == 1) print(eachExam.startDate);
                                // if(index== 1) print(startDate);
                                return GestureDetector(
                                  onTap: () {
                                    Get.offAll(
                                      () => QuestionLoadingWidget(
                                          isTestExam: true,
                                          examId: examList[index].id!,
                                          questionConfiguration:
                                              QuestionConfiguration(
                                            difficuly: '',
                                            isSimulateTest: false,
                                            timeInMinute: examList[index].time!,
                                          )),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    eachExam.name ?? "Exam",
                                                    minFontSize: 16,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  AutoSizeText(
                                                    'Free',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.green),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              // Container(
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(Icons
                                              //           .calendar_today),
                                              //       SizedBox(
                                              //         width: 10,
                                              //       ),
                                              //       AutoSizeText(
                                              //         '21 Oct,1:00 pm',
                                              //         style: TextStyle(
                                              //           color: Colors.black
                                              //               .withOpacity(
                                              //                   0.6),
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              // SizedBox(
                                              //   height: 12,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(Icons.lock_clock),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      AutoSizeText(
                                                        "${eachExam.time.toString()} min",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .question_answer),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      AutoSizeText(
                                                        "${eachExam.totalQuestions.toString()} Questions",
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Row(children: [
                                                Icon(Icons.people),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                AutoSizeText('250 enrolled')
                                              ])
                                            ],
                                          ),
                                        ),
                                      )
                                      // Row(
                                      //   children: [
                                      //     AutoSizeText('hi'),
                                      //     AutoSizeText('hi'),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
