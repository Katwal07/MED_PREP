import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../screens/test-history/test_history_screen.dart';

class RevisionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // InkWell(
          //   onTap: () {
          //     Get.to(() => BookmarkedQuestionScreen());
          //   },
          //   child: Container(
          //     width: 160,
          //     alignment: Alignment.center,
          //     margin: EdgeInsets.all(10),
          //     color: Colors.white,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           padding: EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.blue.withOpacity(0.2),
          //           ),
          //           child: Icon(
          //             FontAwesomeIcons.solidBookmark,
          //             color: Theme.of(context).accentColor,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         AutoSizeText(
          //           'Bookmarked\nQuestions',
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black87,
          //             inherit: false,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          InkWell(
            onTap: () {
              // Get.to(() => LeadershipScreen());
              Get.to(() => TestHistoryScreen());
            },
            child: Container(
              width: 160,
              decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.2),
                    ),
                    child: Icon(
                      FontAwesomeIcons.paragraph,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    'Test\nHistory',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      inherit: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   width: 160,
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.all(10),
          //   color: Colors.white,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.blue.withOpacity(0.2),
          //         ),
          //         child: Icon(
          //           FontAwesomeIcons.copy,
          //           color: Theme.of(context).accentColor,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       AutoSizeText(
          //         'Bookmarked\nFlashcards',
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           color: Colors.black87,
          //           inherit: false,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Get.to(DiscussionScreen());
          //   },
          //   child: Container(
          //     width: 160,
          //     alignment: Alignment.center,
          //     margin: EdgeInsets.all(10),
          //     color: Colors.white,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           padding: EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.blue.withOpacity(0.2),
          //           ),
          //           child: Icon(
          //             FontAwesomeIcons.question,
          //             color: Theme.of(context).colorScheme.secondary,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         AutoSizeText(
          //           'Discussed\nQuestions',
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //             color: Colors.black87,
          //             inherit: false,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
