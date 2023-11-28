import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/provider/task_provider.dart';
import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';
import 'package:provider/provider.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  DateTime getStartOfWeek(DateTime date) {
    //월요일
    // if (date.weekday == DateTime.sunday) {
    //   return date.subtract(const Duration(days: 6));
    // } else {
    //   return date.subtract(Duration(days: date.weekday - 1));
    // }
    if (date.weekday == DateTime.monday) {
      return date;
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

  // void _resetWeekData() {
  //   weekData = List.generate(
  //     7,
  //     (i) => BarChartGroupData(
  //       x: i,
  //       barRods: [
  //         BarChartRodData(
  //           toY: 0,
  //           gradient: const LinearGradient(
  //             colors: [
  //               Colors.blue,
  //               Colors.cyan,
  //             ],
  //             begin: Alignment.bottomCenter,
  //             end: Alignment.topCenter,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> weekData = [];
    DateTime now = DateTime.now();
    DateTime startOfWeek = getStartOfWeek(now);
    DateTime endOfWeek = getEndOfWeek(now);

    List<String> dropdownLabels = [
      '이번주',
      '저번주',
      '${startOfWeek.add(const Duration(days: -14)).toString().substring(5, 10)} ~ ${endOfWeek.add(const Duration(days: -8)).toString().substring(5, 10)}',
      '${startOfWeek.add(const Duration(days: -21)).toString().substring(5, 10)} ~ ${endOfWeek.add(const Duration(days: -15)).toString().substring(5, 10)}',
    ];
    String selectedDropdownLabel = dropdownLabels[0];

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Padding(
      //   padding: const EdgeInsets.only(left: 20),
      //   child: DropdownButton2<String>(
      //     items: dropdownLabels.map((String label) {
      //       return DropdownMenuItem<String>(
      //         value: label,
      //         child: Text(label),
      //       );
      //     }).toList(),
      //     onChanged: (String? newValue) {
      //       if (newValue != null) {
      //         selectedDropdownLabel = newValue;
      //         if (newValue == dropdownLabels[0]) {
      //           startOfWeek = getStartOfWeek(DateTime.now());
      //           endOfWeek = getEndOfWeek(DateTime.now());
      //         } else if (newValue == dropdownLabels[1]) {
      //           startOfWeek = getStartOfWeek(
      //               DateTime.now().subtract(const Duration(days: 7)));
      //           endOfWeek = getEndOfWeek(
      //               DateTime.now().subtract(const Duration(days: 7)));
      //         } else if (newValue == dropdownLabels[2]) {
      //           startOfWeek = getStartOfWeek(
      //             DateTime.now().subtract(const Duration(days: 14)),
      //           );
      //           endOfWeek = getEndOfWeek(
      //             DateTime.now().subtract(const Duration(days: 8)),
      //           );
      //         } else if (newValue == dropdownLabels[3]) {
      //           startOfWeek = getStartOfWeek(
      //             DateTime.now().subtract(const Duration(days: 21)),
      //           );
      //           endOfWeek = getEndOfWeek(
      //             DateTime.now().subtract(const Duration(days: 15)),
      //           );
      //         }
      //       }
      //     },
      //     value: selectedDropdownLabel,
      //   ),
      // ),
      SummaryWidget(
        start: startOfWeek,
        end: endOfWeek,
        chartData: weekData,
        type: 'week',
      ),
      ChartWidget(barData: weekData, type: 'week'),
      const RecordsList(),
    ]);
  }
}
