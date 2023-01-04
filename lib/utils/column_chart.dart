// ignore_for_file: invalid_required_positional_param, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ColumnChart extends StatelessWidget {
  // final List<ChartData> chartData = [
  //   ChartData(1, 35, Colors.red),
  //   ChartData(2, 23, Colors.red),
  //   ChartData(3, 34, Colors.red),
  //   ChartData(4, 25, Colors.red),
  //   ChartData(5, 40, Colors.red),
  //   ChartData(6, 34, Colors.red),
  //   ChartData(7, 25, Colors.red),
  //   ChartData(8, 40, Colors.red),
  //   ChartData(9, 35, Colors.red),
  //   ChartData(10, 23, Colors.red),
  //   ChartData(11, 34, Colors.red),
  //   ChartData(12, 25, Colors.red),
  //   ChartData(13, 40, Colors.red),
  //   ChartData(14, 34, Colors.red),
  //   ChartData(15, 25, Colors.red),
  //   ChartData(16, 40, Colors.red),
  // ];

  List<ChartData> chartData = [];
  List data;
  ColumnChart({required this.data}) {
    for (var x in data) {
      chartData.add(ChartData(x[0], x[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // enableAxisAnimation: true,
      // backgroundColor: Colors.white,
      series: <ChartSeries<ChartData, int>>[
        ColumnSeries<ChartData, int>(
          // width: 0.5,
          borderColor: Colors.white,
          color:Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => (int.parse(data.x)),
          yValueMapper: (ChartData data, _) => (data.y),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(@required this.x, @required this.y);
  final String x;
  final double y;
  // final Color color;
}
