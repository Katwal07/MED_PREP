import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/home/my_stats.dart';

class UserStatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Hard', 35),
      ChartData('Medium', 40),
      ChartData('Easy', 25),
    ];
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          width: screenSize.width,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: screenSize.width /
                  (2 / (screenSize.height / screenSize.width)),
              child: Padding(
                child: AutoSizeText(
                  'My Stats',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
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
      ),
      body: ListView(
        children: [
          MyStatsHomePage(),
          SizedBox(),
          Container(
            height: 400,
            child: SfCircularChart(
                legend: Legend(
                    isVisible: true,
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                title: ChartTitle(
                    text: 'Question Pattern',
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)))
                ]),
          ),
          SizedBox(),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(
                  text: 'Monthly Exam Pattern',
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)), //Chart title.
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom), // Enables the legend.
              tooltipBehavior:
                  TooltipBehavior(enable: true), // Enables the tooltip.
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    dataSource: [
                      SalesData('Jan', 3),
                      SalesData('Feb', 5),
                      SalesData('Mar', 10),
                      SalesData('Apr', 6),
                      SalesData('May', 5)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true) // Enables the data label.
                    )
              ]),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
