import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class MonthlySummary extends StatelessWidget {
  const MonthlySummary({super.key});

  DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 1)
        .subtract(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> monthData = [];
    DateTime now = DateTime.now();

    DateTime startOfMonth = getStartOfMonth(now);
    DateTime endOfMonth = getEndOfMonth(now);

    for (var i = 0; i < DateTime(now.year, now.month + 1, 0).day; i++) {
      monthData.add(
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
          start: startOfMonth,
          end: endOfMonth,
          chartData: monthData,
          type: 'month'),
      ChartWidget(barData: monthData, type: 'month'),
      const RecordsList()
    ]);
  }
}
