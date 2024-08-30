// ignore_for_file: unused_field

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../widgets/workout/clinical_list.dart';
import '../../widgets/workout/minor_subject_list.dart';
import '../../widgets/workout/preclinical_list.dart';
import '../../widgets/workout/short_list.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with AutomaticKeepAliveClientMixin {
  late TabController _controller;
  Api _api = locator<Api>();
  bool isLoading = false;

  int selectedIndex = 0;
  var tabData;

  int selectedIndexGetter() => selectedIndex;
  // Question myQuestion;

  @override
  void initState() {
    super.initState();
    // fetchRandomQuestion();
  }

  // fetchRandomQuestion() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     myQuestion = await locator<Api>().getRandomQuestion();
  //   } catch (err) {
  //     print(err);
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
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
                    "Workouts",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 0,
                    right: 10,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              initialIndex: selectedIndex,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // BaseScreen<ExamViewModel>(
                      //   onModelReady: (model) =>
                      //       model.fetchListOfExams(context),
                      //   builder: (context, model, child) => model.state ==
                      //           ViewState.Busy
                      //       ? kLoadingWidget(context)
                      //       : Container(
                      //           height: 200,
                      //           margin: EdgeInsets.all(10),
                      //           decoration: BoxDecoration(
                      //               color: Colors.lightBlue[10],
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(10))),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Center(
                      //                 child: Align(
                      //                   alignment: Alignment.topLeft,
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: AutoSizeText('Available Tests',
                      //                         textAlign: TextAlign.left,
                      //                         style: TextStyle(
                      //                           fontSize: 19,
                      //                           fontWeight: FontWeight.normal,
                      //                           color: Theme.of(context)
                      //                               .accentColor,
                      //                         )),
                      //                   ),
                      //                 ),
                      //               ),
                      //               Divider(),
                      //               Expanded(
                      //                 child: ListView.builder(
                      //                   itemCount: 1,
                      //                   itemBuilder: (context, index) {
                      //                     return ListTile(
                      //                       leading: Icon(
                      //                         FontAwesomeIcons.penAlt,
                      //                         size: 17,
                      //                         color:
                      //                             Theme.of(context).accentColor,
                      //                       ),
                      //                       title: AutoSizeText(
                      //                         model.getExamList.exams[index]
                      //                             .name,
                      //                         style: TextStyle(
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.normal,
                      //                         ),
                      //                       ),
                      //                       subtitle: AutoSizeText(
                      //                         '${model.getExamList.exams[index].totalQuestions.toString()} questions',
                      //                         style: TextStyle(
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.normal,
                      //                         ),
                      //                       ),
                      //                       // trailing: ElevatedButton(
                      //                       //   elevation: 10,
                      //                       //   onPressed: () {},
                      //                       //   child: Container(
                      //                       //     child: AutoSizeText('Start Exam',
                      //                       //         style: TextStyle(
                      //                       //           color: Colors.black87,
                      //                       //           fontSize: 15,
                      //                       //           fontWeight:
                      //                       //               FontWeight.normal,
                      //                       //         )),
                      //                       //   ),
                      //                       // ),
                      //                     );
                      //                   },
                      //                 ),
                      //               ),
                      //               Container(
                      //                 margin:
                      //                     EdgeInsets.symmetric(horizontal: 30),
                      //                 child: ElevatedButton(
                      //                     color: Theme.of(context).accentColor,
                      //                     onPressed: () {
                      //                       Get.to(() => MyTestScreen());
                      //                     },
                      //                     child: Center(
                      //                         child: AutoSizeText('See More',
                      //                             style: TextStyle(
                      //                               fontSize: 16,
                      //                               fontWeight: FontWeight.bold,
                      //                               color: Colors.white,
                      //                             )))),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      // ),

                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          unselectedLabelColor: Colors.black87,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.lightBlue[50]
                              border: Border.all(color: Colors.blueAccent)
                              ),
                          tabs: [
                            Container(
                              height: 40,
                              child: Center(
                                child: AutoSizeText(
                                  "Pre-Clinical",
                                  style: TextStyle(
                                    color: selectedIndex == 0
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Center(
                                child: AutoSizeText(
                                  "Major",
                                  style: TextStyle(
                                    color: selectedIndex == 1
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Center(
                                child: AutoSizeText(
                                  "Minor",
                                  style: TextStyle(
                                    color: selectedIndex == 2
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: Center(
                                child: AutoSizeText(
                                  "Short",
                                  style: TextStyle(
                                    color: selectedIndex == 3
                                        ? Colors.blueAccent
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                          onTap: (int index) {
                            setState(() {
                              selectedIndex = index;
                              print('Yhisis ' + selectedIndex.toString());
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _controller,
                            children: [
                              SubjectListingPreClinical(
                                SelectedTab: 'Pre-Clinical',
                              ),
                              SubjectListingMajor(
                                SelectedTab: 'Major',
                              ),
                              SubjectListingMinor(
                                SelectedTab: 'Minor',
                              ),
                              SubjectListingShort(
                                SelectedTab: 'Short',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
