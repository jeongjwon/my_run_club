import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  DateTime getStartOfWeek(DateTime date) {
    //월요일
    if (date.weekday == DateTime.sunday) {
      return date.subtract(const Duration(days: 6));
    } else {
      return date.subtract(Duration(days: date.weekday - 1));
    }
  }

  DateTime getEndOfWeek(DateTime date) {
    // 일요일
    if (date.weekday == DateTime.sunday) {
      return date;
    } else {
      return date.add(Duration(days: DateTime.saturday - date.weekday + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> weekData = [];

    DateTime now = DateTime.now();

    DateTime startOfWeek = getStartOfWeek(now);

    DateTime endOfWeek = getEndOfWeek(now);

    print('start : ${startOfWeek.day} , end : ${endOfWeek.day}');

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
