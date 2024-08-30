// ignore_for_file: unused_local_variable

// import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../common/constants.dart';
import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/chapter.dart';
import '../../../models/payment.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../constants/colors.dart';
import '../../constants/loading.dart';
import '../../widgets/home/subject_icon_items.dart';
import '../../widgets/login/reuseable_components.dart';
import '../../widgets/workout/filter_container.dart';
import '../../widgets/workout/floating_question_modal.dart';
import '../package/package_Screen.dart';

class SubjectDetailScreen extends StatefulWidget {
  final SubjectItem subject;

  SubjectDetailScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  bool hasPayment = false;
  StorageService _storageService = locator<StorageService>();

  final _api = locator<Api>();

  var chapterList = <Chapter>[];
  var selectedChapters = <Chapter>[];

  bool isLoading = true;

  Future<void> myPaymentStatus() async {
    // Get payment Status and populate chapters
    await _api.getMyPayment();

    final resolvedFuture = await Future.wait([
      _api.getMyPayment(),
      _api.getChaptersBySectionId(id: widget.subject.section!.id!)
    ]);

    // Parse Payment
    final payment = resolvedFuture[0] as PaymentList;

    // Parse Chapter
    final chapters = resolvedFuture[1] as ChapterList;

    final state =
        await _storageService.getBoolFromSharedPrefs(key: PAYMENT_STATUS);
    hasPayment = state;
    isLoading = false;

    setState(() {
      chapterList = chapters.chapters;
    });
  }

  @override
  void initState() {
    myPaymentStatus().then((value) {
      // setState(() {});
    });

    // readPreference();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            print('Button is pressed');
            Navigator.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.xmark),
          color: MedUI.primaryBrandColor,
        ),
        title: AutoSizeText(
          widget.subject.section!.name!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: screenSize.width,
            //   child: FittedBox(
            //     fit: BoxFit.cover,
            //     child: Container(
            //       width: screenSize.width /
            //           (2 / (screenSize.height / screenSize.width)),
            //       child: Padding(
            //         child:
            //         padding: const EdgeInsets.only(
            //           top: 10,
            //           left: 10,
            //           bottom: 20,
            //           right: 10,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AutoSizeText(
                'Here are the chapters belong to this section:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            isLoading
                ? kLoadingWidget(context)
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: (4 / 1.6),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 5,
                    // mainAxisSpacing: 2,
                    //physics:BouncingScrollPhysics(),
                    children: chapterList
                        .map((eachChapter) => Container(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () {
                                  toggleChapter(eachChapter);
                                  print("This chapter is " + eachChapter.id!);
                                },
                                child: Chip(
                                  elevation: 1.0,
                                  backgroundColor:
                                      selectedChapters.contains(eachChapter)
                                          ? Colors.blue
                                          : Colors.white.withOpacity(0.4),
                                  label: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.bookMedical,
                                        color: tButtonColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: AutoSizeText(
                                          '${eachChapter.name}',
                                          textAlign: TextAlign.start,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: selectedChapters
                                                      .contains(eachChapter)
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: T6Button(
                showIcon: !hasPayment ? true : false,
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                textContent: "START WORKOUT",
                onPressed: () {
                  // debugger();
                  // showFloatingModalBottomSheet(
                  //   context: context,
                  //   builder: (_) => QuestionFilterContainer(
                  //       fromSubject: true,
                  //       subject: widget.subject,
                  //       selectedChapters: selectedChapters),
                  // );
                  if (hasPayment) {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (_) => QuestionFilterContainer(
                          fromSubject: true,
                          subject: widget.subject,
                          selectedChapters: selectedChapters),
                    );
                  } else {
                    Tools.showErrorToast(
                        'Payment Failed. Please Subscribe to our Packages');
                    Get.to(PackageScreen());
                  }

                  // Future paymentState= _api.getMyPayment();

                  // Get.offAll(PracticeScreen());
                  // showMaterialModalBottomSheet(
                  //     context: context,
                  //     builder: (context, scrollController) => Container(
                  //           color: Colors.green,
                  //         ));
                  // showFloatingModalBottomSheet(
                  //   context: context,
                  //   builder: (_) => QuestionFilterContainer(
                  //     fromSubject: true,
                  //     subject: widget.subject,
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateList(dynamic data) {
    List<Widget> widgetList = [];

    data.keys.forEach((key) {
      if (key == 'total') {
        widgetList.add(
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: AutoSizeText(
              'Great! We\'ve ${data[key]} questions available for you to practice.  We\'ve following chapters:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      } else {
        widgetList.add(
          AutoSizeText(
            '$key (${data[key]})',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        );
      }
    });

    return widgetList.reversed.toList();
  }

  void toggleChapter(Chapter eachChapter) {
    // debugger();
    if (selectedChapters.contains(eachChapter)) {
      setState(() {
        selectedChapters.remove(eachChapter);
      });
    } else {
      setState(() {
        selectedChapters.add(eachChapter);
      });
    }
  }
}
