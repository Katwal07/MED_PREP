import 'package:auto_size_text/auto_size_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import '../../../enums/viewstate.dart';
import '../../screens/base_screen.dart';
import '../../viewmodels/userstat_model.dart';
import '../shimmer/my_stats_shimmer.dart';

class MyStatsHomePage extends StatefulWidget {
  @override
  _MyStatsHomePageState createState() => _MyStatsHomePageState();
}

class _MyStatsHomePageState extends State<MyStatsHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<UserStatModel>(
        onModelReady: (model) => model.getMyStat(),
        builder: (context, model, child) => model.state == ViewState.Busy ||
                model.myStat!.totalCorrectAttempt == null
            ? MyStatsShimmer()
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CircularPercentIndicator(
                      radius: 74,
                      progressColor: Colors.lightBlueAccent,
                      percent: model.myStat!.totalCorrectAttempt == null ||
                              model.myStat!.totalQuestionAttempt == null
                          ? 0
                          : ((model.myStat!.totalCorrectAttempt! /
                              model.myStat!.totalQuestionAttempt!)),
                      animation: true,
                      lineWidth: 10.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            model.myStat!.totalQuestionAttempt == null
                                ? 'N/A'
                                : model.myStat!.totalQuestionAttempt == 0
                                    ? '0 %'
                                    : '${((model.myStat!.totalCorrectAttempt! / model.myStat!.totalQuestionAttempt!) * 100).toStringAsFixed(1)}%',
                            style: TextStyle(fontSize: 30),
                          ),
                          AutoSizeText('Correct')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          'Overall Score',
                          style: TextStyle(color: Colors.black45),
                        ),
                        AutoSizeText(model.myStat!.totalCorrectAttempt == null
                            ? 'N/A'
                            : model.myStat!.totalCorrectAttempt == 0
                                ? '0 correct'
                                : '${model.myStat!.totalCorrectAttempt}/${model.myStat!.totalQuestionAttempt} correct'),
                        Divider(),
                        AutoSizeText(
                          'AVG Time Per Question',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        AutoSizeText(model.myStat!.averageTimePerQuestion == null
                            ? 'N/A'
                            : model.myStat!.averageTimePerQuestion == 0
                                ? '0 sec'
                                : '${model.myStat!.averageTimePerQuestion}s'),
                        Divider(),
                        AutoSizeText(
                          'Last 24 Hours',
                          style: TextStyle(color: Colors.black45),
                        ),
                        AutoSizeText(model.myStat!.dailyQuestionAttempt == null
                            ? 'N/A'
                            : model.myStat!.dailyQuestionAttempt == 0
                                ? '0 attempted'
                                : '${model.myStat!.dailyQuestionAttempt} Questions'),
                        Divider(),
                        AutoSizeText(
                          'Last 7 Days',
                          style: TextStyle(color: Colors.black45),
                        ),
                        AutoSizeText(model.myStat!.weeklyQuestionAttempt == null
                            ? 'N/A'
                            : model.myStat!.weeklyQuestionAttempt == 0
                                ? '0 attempted'
                                : '${model.myStat!.weeklyQuestionAttempt} Questions'),
                      ],
                    ),
                  )
                ],
              ));
  }
}
