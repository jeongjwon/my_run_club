import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  DateTime getStartOfWeek(DateTime date) {
    if (date.weekday == 7) {
      return date;
    } else {
      DateTime thisSunday = date.subtract(Duration(days: date.weekday - 7));
      DateTime lastSunday = thisSunday.subtract(const Duration(days: 7));

      return lastSunday;
    }
  }

  DateTime getEndOfWeek(DateTime date) {
    // int daysUntilSaturday = 6 - date.weekday;
    // return date.add(Duration(days: daysUntilSaturday));
    if (date.weekday == 7) {
      int daysUntilSaturday = 6;
      return date.add(Duration(days: daysUntilSaturday));
    } else {
      int daysUntilSaturday = 6 - date.weekday;
      return date.add(Duration(days: daysUntilSaturday));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> weekData = [];

    DateTime now = DateTime.now();

    DateTime startOfWeek = getStartOfWeek(now);

    DateTime endOfWeek = getEndOfWeek(now);

    for (var i = 0; i < 7; i++) {
      weekData.add(
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
        start: startOfWeek,
        end: endOfWeek,
        chartData: weekData,
        type: 'week',
      ),
      ChartWidget(barData: weekData, type: 'week'),
      const RecordsList()
    ]);
  }
}
