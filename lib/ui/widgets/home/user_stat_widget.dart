// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'my_stats.dart';
import 'questionofTheDay.dart';

class UserStatWidget extends StatelessWidget {
  final bool isQuestionOfDay;

  const UserStatWidget({Key? key, this.isQuestionOfDay = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () { 
          // Get.to(
          //   UserStatScreen(),
          // );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          margin: EdgeInsets.symmetric(horizontal: 10),
          // width: screenSize.width * 0.90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: isQuestionOfDay ? QuestionofTheDay() : MyStatsHomePage(),
        ),
      ),
    );
  }
}
