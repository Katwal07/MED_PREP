// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:med_prep/locator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/tools.dart';
import '../../../models/app_config.dart';
import '../../../models/question.dart';
import '../../../services/api_service.dart';
import '../../design/colors.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/home/menu_title_widget.dart';
import '../../widgets/home/revision_widget.dart';
import '../../widgets/home/subject_icon_items.dart';
import '../../widgets/home/treasure_widget.dart';
import '../../widgets/home/user_stat_widget.dart';
import '../package/package_Screen.dart';
import '../testScreen/test_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  Question? myQuestion;

  var selectedAnswer;

  @override
  void initState() {
    super.initState();
    // fetchRandomQuestion();
  }

  // fetchAndStoreSubjects() async {
  //   try {
  //     // Fetch Subjects
  //     SubjectList list = await locator<Api>().getAllSubjects();
  //   } catch (err) {}
  // }

  // fetchRandomQuestion() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     myQuestion = await locator<Api>().getRandomQuestion();
  //     print(myQuestion.correctAnswer);
  //   } catch (err) {
  //     print(err);
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MedUI.backgroundColor,
      drawer: DrawerWidget(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: WaterDropHeader(),
        child: SingleChildScrollView(
          child: SafeArea(
            left: false,
            right: false,
            child: FutureBuilder<AppConfig?>(
                future: locator<Api>().getAppConfiguration(),
                builder: (context, snapshot) {
                  bool showQuestionOfDay = false;
                  bool showTreasures = false;

                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      showQuestionOfDay = snapshot.data!.showQuestionOfDay!;
                      showTreasures = snapshot.data!.showTreasures!;
                    }
                  }

                  return Container(
                    child: Column(
                      children: [
                        Logo(),
                        SubjectImages(),
                        MenuTitleWidget(
                          menuTitleName: 'My Stats',
                        ),
                        UserStatWidget(),
                        MenuTitleWidget(
                          menuTitleName: 'Revisions',
                        ),
                        RevisionWidget(),
                        if (showTreasures)
                          MenuTitleWidget(
                            menuTitleName: 'Treasure',
                          ),
                        if (showTreasures) TreasureWidget(),
                        if (showQuestionOfDay)
                          MenuTitleWidget(
                            menuTitleName: 'Question of The Day',
                          ),
                        if (showQuestionOfDay)
                          UserStatWidget(
                            isQuestionOfDay: true,
                          ),
                        // isLoading ? kLoadingWidget(context) : getRandomQuestion(),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  // Widget getRandomQuestionFromOtherHtmlParser() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20),
  //     child: Column(
  //       children: [
  //         Align(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               AutoSizeText(
  //                 myQuestion?.sectionName ?? 'No Section',
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               ElevatedButton(
  //                 color: Colors.blueAccent,
  //                 onPressed: () {
  //                   fetchRandomQuestion();
  //                 },
  //                 child: AutoSizeText(
  //                   'Random',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         HtmlWidget(
  //           myQuestion.question,
  //           customStylesBuilder: (e) {
  //             return {
  //               'color': 'black',
  //               'font-size': '18px',
  //               'font-weight': 'normal'
  //             };
  //           },
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         // Option A
  //         InkWell(
  //           onTap: () {
  //             if (myQuestion.correctAnswer == CorrectAnswer.A) {
  //               Get.snackbar(
  //                 'Correct Anser',
  //                 'Your Answer is correct',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             } else {
  //               Get.snackbar(
  //                 'Wrong Anser',
  //                 'Your Answer is incorrect',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             }
  //           },
  //           child: Container(
  //             height: 50,
  //             color: Colors.black12,
  //             child: ListTile(
  //               title: AutoSizeText(
  //                 myQuestion.optionA,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         // Option B
  //         InkWell(
  //           onTap: () {
  //             print(myQuestion.correctAnswer);
  //             if (myQuestion.correctAnswer == CorrectAnswer.B) {
  //               Get.snackbar(
  //                 'Correct Anser',
  //                 'Your Answer is correct',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             } else {
  //               Get.snackbar(
  //                 'Wrong Anser',
  //                 'Your Answer is incorrect',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             }
  //           },
  //           child: Container(
  //             height: 50,
  //             color: Colors.black12,
  //             child: ListTile(
  //               title: AutoSizeText(
  //                 myQuestion.optionB,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         // Option C
  //         InkWell(
  //           onTap: () {
  //             if (myQuestion.correctAnswer == CorrectAnswer.C) {
  //               Get.snackbar(
  //                 'Correct Anser',
  //                 'Your Answer is correct',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             } else {
  //               Get.snackbar(
  //                 'Wrong Anser',
  //                 'Your Answer is incorrect',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             }
  //           },
  //           child: Container(
  //             height: 50,
  //             color: Colors.black12,
  //             child: ListTile(
  //               title: AutoSizeText(
  //                 myQuestion.optionC,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             if (myQuestion.correctAnswer == CorrectAnswer.D) {
  //               Get.snackbar(
  //                 'Correct Anser',
  //                 'Your Answer is correct',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             } else {
  //               Get.snackbar(
  //                 'Wrong Anser',
  //                 'Your Answer is incorrect',
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: Colors.blueAccent,
  //                 colorText: Colors.white,
  //               );
  //             }
  //           },
  //           child: Container(
  //             height: 50,
  //             color: Colors.black12,
  //             child: ListTile(
  //               title: AutoSizeText(
  //                 myQuestion.optionD,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         HtmlWidget(
  //           myQuestion.explanation,
  //           customStylesBuilder: (elm) {
  //             if (elm.classes.contains('greenText')) {
  //               return {
  //                 'color': 'blue',
  //                 'font-weight': 'bold',
  //               };
  //             }
  //             return null;
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget getRandomQuestion() {
  //   return Column(
  //     children: [
  //       Align(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             AutoSizeText(
  //               myQuestion?.sectionName ?? 'No Section',
  //               style: TextStyle(color: Colors.black),
  //             ),
  //             ElevatedButton(
  //               color: Colors.blueAccent,
  //               onPressed: () {
  //                 fetchRandomQuestion();
  //               },
  //               child: AutoSizeText(
  //                 'Random',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Html(
  //         data: myQuestion.question,
  //         // blacklistedElements: ['tbody', 'table'],
  //         //Optional parameters:
  //         style: {
  //           "html": Style(
  //             backgroundColor: Colors.transparent,
  //           ),
  //           "p": Style(color: Colors.black),
  //           "h1": Style(
  //             textAlign: TextAlign.center,
  //           ),
  //           "table": Style(
  //             backgroundColor: Colors.white,
  //           ),
  //           "tr": Style(
  //             border: Border(bottom: BorderSide(color: Colors.grey)),
  //           ),
  //           "th": Style(
  //             padding: EdgeInsets.all(6),
  //             backgroundColor: Colors.grey,
  //           ),
  //           "td": Style(
  //             padding: EdgeInsets.all(6),
  //           ),
  //           "var": Style(fontFamily: 'serif'),
  //         },

  //         customRender: {
  //           "flutter": (RenderContext context, Widget child, attributes, _) {
  //             return FlutterLogo(
  //               style: (attributes['horizontal'] != null)
  //                   ? FlutterLogoStyle.horizontal
  //                   : FlutterLogoStyle.markOnly,
  //               textColor: context.style.color,
  //               size: context.style.fontSize.size * 5,
  //             );
  //           },
  //         },
  //         onLinkTap: (url) {
  //           print("Opening $url...");
  //         },
  //         onImageTap: (src) {
  //           print(src);
  //         },
  //         onImageError: (exception, stackTrace) {
  //           print(exception);
  //         },
  //       ),
  //       Container(
  //         height: 50,
  //         color: Colors.black12,
  //         child: ListTile(
  //           title: AutoSizeText(
  //             myQuestion.optionA,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         height: 50,
  //         color: Colors.black12,
  //         child: ListTile(
  //           title: AutoSizeText(
  //             myQuestion.optionB,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         height: 50,
  //         color: Colors.black12,
  //         child: ListTile(
  //           title: AutoSizeText(
  //             myQuestion.optionC,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         height: 50,
  //         color: Colors.black12,
  //         child: ListTile(
  //           title: AutoSizeText(
  //             myQuestion.optionD,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Html(
  //         data: myQuestion.explanation,
  //         style: {
  //           "html": Style(
  //             backgroundColor: Colors.transparent,
  //           ),
  //           "p": Style(
  //             color: Colors.black,
  //           ),
  //           "h1": Style(
  //             textAlign: TextAlign.center,
  //           ),
  //           "table": Style(
  //             backgroundColor: Colors.white,
  //           ),
  //           "tr": Style(
  //             color: Colors.black,
  //             border: Border(bottom: BorderSide(color: Colors.grey)),
  //           ),
  //           "th": Style(
  //             color: Colors.black,
  //             padding: EdgeInsets.all(6),
  //             backgroundColor: Colors.grey,
  //           ),
  //           "td": Style(
  //             color: Colors.black,
  //             padding: EdgeInsets.all(6),
  //           ),
  //           "li": Style(
  //             color: Colors.black,
  //             margin: EdgeInsets.all(6),
  //           ),
  //           "div": Style(
  //             color: Colors.blue,
  //           ),
  //           "var": Style(
  //             fontFamily: 'serif',
  //           ),
  //         },
  //       )
  //     ],
  //   );
  // }

}

class Logo extends StatelessWidget {
  final Function? onClickSearch;

  const Logo({Key? key, this.onClickSearch}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(PackageScreen());
      },
      child: Container(
        alignment: Alignment.topCenter,
        width: screenSize.width,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Container(
            width: screenSize.width,
            constraints: BoxConstraints(minHeight: 50),
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.bottomCenter,
            //     end: Alignment.topCenter,
            //     colors: [const Color(0xFF0762d5), const Color(0xFFffffff)],
            //   ),
            // ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  // top: 55,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.linode,
                      // color: Theme.of(context).accentColor.withOpacity(0.6),
                      color: kLightAccent,
                      size: 22,
                    ),
                    onPressed: () {
                      Get.to(() => MyTestScreen());
                    },
                  ),
                ),
                Positioned(
                  // top: 55,

                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.alignLeft,
                      // color: Theme.of(context).accentColor.withOpacity(0.9),
                      color: kLightAccent,
                      size: 22,
                    ),
                    onPressed: () {
                      // eventBus.fire('drawer');
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 40),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Center(
                            child: Image.asset(
                              'assets/images/logo_transparent_1.png',
                              height: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
