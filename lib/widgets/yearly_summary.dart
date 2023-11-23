import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class YearlySummary extends StatelessWidget {
  const YearlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> yearData = [];

    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear =
        DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1));

    for (var i = 0; i < 12; i++) {
      yearData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: 0,
              gradient: const LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.cyan,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ],
        ),
      );
    }

    return Column(children: [
      SummaryWidget(
        start: startOfYear,
        end: endOfYear,
        chartData: yearData,
        type: 'year',
      ),
      ChartWidget(barData: yearData, type: 'year'),
      const RecordsList()
    ]);
  }
}
