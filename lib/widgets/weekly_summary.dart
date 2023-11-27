import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/widgets/chart_widget.dart';
import 'package:my_run_club/widgets/records_list.dart';
import 'package:my_run_club/widgets/summary_widget.dart';

class WeeklySummary extends StatefulWidget {
  const WeeklySummary({super.key});

  @override
  State<WeeklySummary> createState() => _WeeklySummaryState();
}

class _WeeklySummaryState extends State<WeeklySummary> {
  late DateTime startOfWeek;
  late DateTime endOfWeek;
  late List<BarChartGroupData> weekData;
  late List<String> dropdownLabels;
  late String selectedDropdownLabel;

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

  void _resetWeekData() {
    weekData = List.generate(
      7,
      (i) => BarChartGroupData(
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

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    startOfWeek = getStartOfWeek(now);
    endOfWeek = getEndOfWeek(now);

    dropdownLabels = [
      '이번주',
      '저번주',
      '${startOfWeek.add(const Duration(days: -14)).toString().substring(5, 10)} ~ ${endOfWeek.add(const Duration(days: -8)).toString().substring(5, 10)}',
      '${startOfWeek.add(const Duration(days: -21)).toString().substring(5, 10)} ~ ${endOfWeek.add(const Duration(days: -15)).toString().substring(5, 10)}',
    ];
    selectedDropdownLabel = dropdownLabels[0];

    _resetWeekData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: DropdownButton2<String>(
          items: dropdownLabels.map((String label) {
            return DropdownMenuItem<String>(
              value: label,
              child: Text(label),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _resetWeekData();
              setState(() {
                selectedDropdownLabel = newValue;
                if (newValue == '이번주') {
                  startOfWeek = getStartOfWeek(DateTime.now());
                  endOfWeek = getEndOfWeek(DateTime.now());
                } else if (newValue == '저번주') {
                  startOfWeek = getStartOfWeek(
                      DateTime.now().subtract(const Duration(days: 7)));
                  endOfWeek = getEndOfWeek(
                      DateTime.now().subtract(const Duration(days: 7)));
                } else if (newValue == dropdownLabels[2]) {
                  startOfWeek = getStartOfWeek(
                    DateTime.now().subtract(const Duration(days: 14)),
                  );
                  endOfWeek = getEndOfWeek(
                    DateTime.now().subtract(const Duration(days: 8)),
                  );
                } else if (newValue == dropdownLabels[3]) {
                  startOfWeek = getStartOfWeek(
                    DateTime.now().subtract(const Duration(days: 21)),
                  );
                  endOfWeek = getEndOfWeek(
                    DateTime.now().subtract(const Duration(days: 15)),
                  );
                }
              });
            }
          },
          value: selectedDropdownLabel,
        ),
      ),
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
