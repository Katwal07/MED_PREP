import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'shimmer_container.dart';

class MyStatsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CircularPercentIndicator(
            radius: 74,
            progressColor: Colors.lightBlueAccent,
            animation: true,
            lineWidth: 10.0,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerContainer(height: 30.0, width: 40.0),
                AutoSizeText('Loading')
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
              ShimmerContainer(height: 10.0, width: 40.0),
              Divider(),
              AutoSizeText(
                'AVG Time Per Question',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              ShimmerContainer(height: 10.0, width: 40.0),
              Divider(),
              AutoSizeText(
                'Last 24 Hours',
                style: TextStyle(color: Colors.black45),
              ),
              ShimmerContainer(height: 10.0, width: 40.0),
              Divider(),
              AutoSizeText(
                'Last 7 Days',
                style: TextStyle(color: Colors.black45),
              ),
              ShimmerContainer(height: 10.0, width: 40.0),
            ],
          ),
        )
      ],
    );
  }
}
