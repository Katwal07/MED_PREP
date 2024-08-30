// ignore_for_file: unused_field

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:med_prep/ui/viewmodels/result_model.dart';
import '../../../enums/viewstate.dart';
import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../constants/loading.dart';
import '../base_screen.dart';
import '../result/result_detail_screen.dart';

class TestHistoryScreen extends StatefulWidget {
  @override
  _TestHistoryScreenState createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
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
                    "Result",
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
              length: 2,
              initialIndex: selectedIndex,
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          unselectedLabelColor: Colors.black87,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue[50]),
                          tabs: [
                            Container(
                              height: 40,
                              child: Center(
                                child: AutoSizeText(
                                  "Exam Result",
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
                                  "Test Result",
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
                          ],
                          onTap: (int index) {
                            setState(() {
                              selectedIndex = index;
                              print('Yhisis ' + selectedIndex.toString());
                            });
                          },
                        ),
                      ),
                      BaseScreen<ResultViewModel>(
                        onModelReady: (model) =>
                            model.fetchListOfResults(context),
                        builder: (context, model, child) => model.state ==
                                ViewState.Busy
                            ? kLoadingWidget(context)
                            : model.resultList!.results.isEmpty
                                ? kLoadingWidget(context)
                                : Expanded(
                                    child: Container(
                                      child: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        controller: _controller,
                                        children: [
                                          SingleChildScrollView(
                                            physics: ScrollPhysics(),
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: model
                                                    .resultList!.results
                                                    .where(
                                                        (e) => e.exam != null)
                                                    .toList()
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            ResultDetailScreen(
                                                              id: model
                                                                  .resultList!
                                                                  .results[
                                                                      index]
                                                                  .id,
                                                            ));
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5.0),
                                                        child: Card(
                                                          elevation: 3.0,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading: Icon(
                                                                    FontAwesomeIcons
                                                                        .book),
                                                                title: AutoSizeText(model
                                                                        .resultList!
                                                                        .results[
                                                                            index]
                                                                        .exam ??
                                                                    'Exam Result'),
                                                                subtitle: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    AutoSizeText(model.resultList!.results[index].isCompleted ==
                                                                            false
                                                                        ? 'Incompleted'
                                                                        : 'Completed'),
                                                                    AutoSizeText(
                                                                        '${model.resultList!.results[index].attemptedQuestions.toString()}/ ${model.resultList!.results[index].totalQuestions.toString()}')
                                                                  ],
                                                                ),
                                                              ),
                                                              // model.resultList.results[index]
                                                              //             .isCompleted ==
                                                              //         false
                                                              //     ? Padding(
                                                              //         padding:
                                                              //             EdgeInsets.symmetric(vertical: 8.0),
                                                              //         child:
                                                              //             Container(
                                                              //           height:
                                                              //               40,
                                                              //           width:
                                                              //               130,
                                                              //           alignment:
                                                              //               Alignment.center,
                                                              //           decoration:
                                                              //               BoxDecoration(
                                                              //             color: Theme.of(context).colorScheme.secondary,
                                                              //             borderRadius: BorderRadius.circular(5.0),
                                                              //           ),
                                                              //           child:
                                                              //               AutoSizeText(
                                                              //             'CONTINUE',
                                                              //             style: TextStyle(color: Colors.white),
                                                              //           ),
                                                              //         ),
                                                              //       )
                                                              //     : SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                }),
                                          ),
                                          SingleChildScrollView(
                                            physics: ScrollPhysics(),
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: model
                                                    .resultList!.results
                                                    .where(
                                                        (e) => e.exam == null)
                                                    .toList()
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        model
                                                                    .resultList!
                                                                    .results[
                                                                        index]
                                                                    .isCompleted ==
                                                                true
                                                            ? Get.to(() =>
                                                                ResultDetailScreen(
                                                                  id: model
                                                                      .resultList!
                                                                      .results[
                                                                          index]
                                                                      .id,
                                                                ))
                                                            : null;
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5.0),
                                                        child: Card(
                                                          elevation: 3.0,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading: Icon(
                                                                    FontAwesomeIcons
                                                                        .book),
                                                                title: AutoSizeText(
                                                                    'RESULT - II'),
                                                                subtitle: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    AutoSizeText(model.resultList!.results[index].isCompleted ==
                                                                            false
                                                                        ? 'Incompleted'
                                                                        : 'Completed'),
                                                                    AutoSizeText(
                                                                        '${model.resultList!.results[index].attemptedQuestions.toString()}/ ${model.resultList!.results[index].totalQuestions.toString()}')
                                                                  ],
                                                                ),
                                                              ),
                                                              // model
                                                              //             .resultList
                                                              //             .results[
                                                              //                 index]
                                                              //             .isCompleted ==
                                                              //         false
                                                              //     ? Padding(
                                                              //         padding: EdgeInsets.symmetric(
                                                              //             vertical:
                                                              //                 8.0),
                                                              //         child:
                                                              //             Container(
                                                              //           height:
                                                              //               40,
                                                              //           width:
                                                              //               130,
                                                              //           alignment:
                                                              //               Alignment.center,
                                                              //           decoration:
                                                              //               BoxDecoration(
                                                              //             color: Theme.of(context)
                                                              //                 .colorScheme
                                                              //                 .secondary,
                                                              //             borderRadius:
                                                              //                 BorderRadius.circular(5.0),
                                                              //           ),
                                                              //           child:
                                                              //               AutoSizeText(
                                                              //             'CONTINUE',
                                                              //             style:
                                                              //                 TextStyle(color: Colors.white),
                                                              //           ),
                                                              //         ),
                                                              //       )
                                                              //     : SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                  // AutoSizeText(_savedResult
                                                  //     .questionList.questions[index].question);
                                                }),
                                          ),
                                        ],
                                      ),
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
}

 
 


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_startup/common/constants.dart';
// import 'package:flutter_startup/models/test_result.dart';
// import 'package:flutter_startup/services/storage_service.dart';
// import 'package:flutter_startup/ui/screens/result/result_screen.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:get/route_manager.dart';

// import '../../../locator.dart';

// class TestHistoryScreen extends StatelessWidget {
//   final StorageService _storageService = locator<StorageService>();
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               width: screenSize.width,
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: Container(
//                   width: screenSize.width /
//                       (2 / (screenSize.height / screenSize.width)),
//                   child: Padding(
//                     child: AutoSizeText(
//                       'Test History',
//                       style: TextStyle(
//                           fontSize: 27,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).accentColor),
//                     ),
//                     padding: const EdgeInsets.only(
//                       top: 10,
//                       left: 10,
//                       bottom: 20,
//                       right: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future:
//                     _storageService.getDataFromSharedPrefs(key: CACHED_RESULTS),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     final _savedResult =
//                         TestResultList.fromJson(jsonDecode(snapshot.data));
//                     return SingleChildScrollView(
//                       physics: ScrollPhysics(),
//                       child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: _savedResult.testResults.length,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () {
//                                 Get.to(() => ResultScreen(
//                                       testResult:
//                                           _savedResult.testResults[index],
//                                     ));
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Card(
//                                   child: HtmlWidget(
//                                     'Test - ${index + 1}',
//                                     textStyle: TextStyle(
//                                       color: Colors.blue[900],
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                             // AutoSizeText(_savedResult
//                             //     .questionList.questions[index].question);
//                           }),
//                     );
//                   }
//                   return Container(
//                     child: AutoSizeText('No data'),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
