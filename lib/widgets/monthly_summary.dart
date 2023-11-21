import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class MonthlySummary extends StatelessWidget {
  const MonthlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

    Duration calculateAverageDuration(List<Duration> durations) {
      List<int> millisecondsList =
          durations.map((duration) => duration.inMilliseconds).toList();

      int averageMilliseconds =
          millisecondsList.reduce((a, b) => a + b) ~/ durations.length;

      return Duration(milliseconds: averageMilliseconds);
    }

    return Column(children: [
      SummaryWidget(
          start: startOfMonth,
          end: endOfMonth,
          calculateAverageDuration: calculateAverageDuration),
      const RecordsList()
    ]);
  }
}
