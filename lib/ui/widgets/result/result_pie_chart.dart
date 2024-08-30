import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: 'Test',
      ),
    );
  }
}
