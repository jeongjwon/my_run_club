import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class YearlySummary extends StatelessWidget {
  const YearlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear =
        DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1));

    Duration calculateAverageDuration(List<Duration> durations) {
      List<int> millisecondsList =
          durations.map((duration) => duration.inMilliseconds).toList();

      int averageMilliseconds =
          millisecondsList.reduce((a, b) => a + b) ~/ durations.length;

      return Duration(milliseconds: averageMilliseconds);
    }

    return Column(children: [
      SummaryWidget(
          start: startOfYear,
          end: endOfYear,
          calculateAverageDuration: calculateAverageDuration),
      const RecordsList()
    ]);
  }
}
