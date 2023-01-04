// ignore_for_file: invalid_required_positional_param, depend_on_referenced_packages, unnecessary_import, unused_import, prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PieChart extends StatelessWidget {
  static String id = 'piechart';

  // final List<ChartData> chartData = [
  //   ChartData('David', '25', Colors.blue),
  //   ChartData('Steve', '38', Colors.red),
  //   ChartData('Jack', '34', Colors.blue),
  //   ChartData('Others', '52', Colors.red),
  // ];

  List<ChartData> chartData = [];
  List data;
  // late TooltipBehaviour _tooltipBehaviour;
  PieChart({required this.data}) {
    for (var x in data) {
      chartData.add(ChartData(x[0], x[1].toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      // palette: [
      //   kdarkorange,
      //   korange,
      //   kpurple,
      //   kwhite,
      // ],
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
        textStyle: TextStyle(
          fontSize: 15,
          // color: Colors.white,
          color: Colors.black
        ),
        isResponsive: true,
      ),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          // strokeColor: kColor3,
          // strokeWidth: 5,
          explode: true,
          explodeIndex: 1,
          dataSource: chartData,
          // radius: '80',
          dataLabelMapper: (ChartData data, _) => (double.parse(data.y).toStringAsFixed(0)),
          yValueMapper: (ChartData data, _) => double.parse(data.y),
          xValueMapper: (ChartData data, _) => data.x,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            showCumulativeValues: true,
            textStyle: TextStyle(
              fontSize: 15,
              // fontFamily: GoogleFonts.lato(),
              // color: Colors.white,
              color: Colors.black,
            ),
            overflowMode: OverflowMode.shift,
            // Avoid labels intersection
            labelIntersectAction: LabelIntersectAction.shift,
            labelPosition: ChartDataLabelPosition.inside,
            connectorLineSettings:
                ConnectorLineSettings(type: ConnectorType.line, length: '10%'),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(@required this.x, @required this.y);
  final String x;
  final String y;
  // final Color color;
}
