import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    Duration calculateAverageDuration(List<Duration> durations) {
      List<int> millisecondsList =
          durations.map((duration) => duration.inMilliseconds).toList();

      int averageMilliseconds =
          millisecondsList.reduce((a, b) => a + b) ~/ durations.length;

      return Duration(milliseconds: averageMilliseconds);
    }

    return Column(children: [
      SummaryWidget(
          start: startOfWeek,
          end: endOfWeek,
          calculateAverageDuration: calculateAverageDuration),
      const RecordsList()
    ]);
  }
}
