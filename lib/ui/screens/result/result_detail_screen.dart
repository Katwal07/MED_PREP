// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/question.dart';
import '../../../services/api_service.dart';
import '../../constants/loading.dart';

class ResultDetailScreen extends StatefulWidget {
  String? id;
  ResultDetailScreen({this.id});
  @override
  State<ResultDetailScreen> createState() => _ResultDetailScreenState();
}

class _ResultDetailScreenState extends State<ResultDetailScreen> {
  Api _api = locator<Api>();

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
                      'Result Detail',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
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
                child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: FutureBuilder<QuestionList>(
                future: _api.getResultById(id: widget.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return kLoadingWidget(context);
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.questions.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Colors.lightBlue[100],
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                      child: Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: <Widget>[
                                      SizedBox(height: 5),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        child: HtmlWidget(
                                          snapshot
                                              .data!.questions[index].question!,
                                          textStyle: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          margin: EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
                                              child: ElevatedButton(
                                                // elevation: 0.0,
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    shape: WidgetStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                    )),
                                                child: Container(
                                                  // height: 55,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "A: ${snapshot.data!.questions[index].optionA}",
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                        letterSpacing: 1,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
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
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    shape: WidgetStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                    )),
                                                child: Container(
                                                  // height: 55,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "B: ${snapshot.data!.questions[index].optionB}",
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                        letterSpacing: 1,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
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
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    shape: WidgetStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                    )),
                                                child: Container(
                                                  // height: 55,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "C: ${snapshot.data!.questions[index].optionC}",
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                        letterSpacing: 1,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
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
                                                        WidgetStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    shape: WidgetStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                    )),
                                                child: Container(
                                                  // height: 55,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      "D: ${snapshot.data!.questions[index].optionD}",
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                        letterSpacing: 1,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flex(
                                              direction: Axis.horizontal,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      'The correct answer is: ${Utils.answerEnumToString(answerOption: snapshot.data!.questions[index].correctAnswer)}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      )
                                    ],
                                  )),
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.green),
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  side: BorderSide.none)),
                                        ),
                                        child: AutoSizeText(
                                          'View Detail Answer',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          showDialog(
                                              barrierDismissible: true,
                                              useSafeArea: true,
                                              // barrierColor:
                                              //     Colors.blue,

                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  backgroundColor: Colors.white,
                                                  insetAnimationDuration:
                                                      const Duration(
                                                          milliseconds: 100),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 450,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              HtmlWidget(
                                                                snapshot
                                                                    .data!
                                                                    .questions[
                                                                        index]
                                                                    .explanation!,
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.5,
                                                                  height: 1.3,
                                                                  color: Colors
                                                                          .blue[
                                                                      900],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            //return false;
                                                          },
                                                          child: AutoSizeText(
                                                            'Close',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
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
                                    )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
