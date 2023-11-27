import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_run_club/provider/task_provider.dart';
import 'package:my_run_club/widgets/running.dart';

class SummaryWidget extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final List<BarChartGroupData> chartData;
  final String type;

  const SummaryWidget({
    Key? key,
    required this.start,
    required this.end,
    required this.chartData,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalDistance = 0.0;
    String unit = "km";
    double distance = 0.0;
    int runningTimes = 0;
    Duration totalWorkoutTime = const Duration();

    List<Duration> totalPace = [];
    Duration averageDuration = const Duration();
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    Stream<QuerySnapshot> runningsList =
        taskProvider.getRunningStandard(start, end);

    Duration calculateAverageDuration(List<Duration> durations) {
      List<int> millisecondsList =
          durations.map((duration) => duration.inMilliseconds).toList();

      int averageMilliseconds =
          millisecondsList.reduce((a, b) => a + b) ~/ durations.length;

      return Duration(milliseconds: averageMilliseconds);
    }

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: taskProvider.getRunningStandard(start, end),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //   return Container();
              // }
              else {
                List<DocumentSnapshot> documents = snapshot.data!.docs;

                runningTimes = documents.length;

                for (var document in documents) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  distance = data['distance'];
                  totalDistance += distance;
                  unit = data['unit'];

                  int hours = int.parse(data['workoutTime'].split(":")[0]);
                  int minutes = int.parse(data['workoutTime'].split(":")[1]);
                  int seconds = int.parse(data['workoutTime'].split(":")[2]);

                  totalWorkoutTime += Duration(
                      hours: hours, minutes: minutes, seconds: seconds);

                  int paceMin =
                      int.parse(data['avgPace'].toString().substring(0, 1));
                  int paceSec = int.parse(data['avgPace'].substring(
                      data['avgPace'].indexOf("'") + 1,
                      data['avgPace'].indexOf('"')));

                  totalPace.add(Duration(minutes: paceMin, seconds: paceSec));

                  Timestamp timestamp = data['date'];
                  DateTime dateTime = timestamp.toDate();

                  if (type == 'week') {
                    int weekday = dateTime.weekday;

                    chartData[weekday - 1] =
                        BarChartGroupData(x: weekday - 1, barRods: [
                      BarChartRodData(
                          toY: chartData[weekday].barRods[0].toY +
                              data['distance'],
                          color: Colors.blue),
                    ]);
                  } else if (type == 'month') {
                    int day = dateTime.day;
                    chartData[day - 1] =
                        BarChartGroupData(x: day - 1, barRods: [
                      BarChartRodData(
                          toY: chartData[day - 1].barRods[0].toY +
                              data['distance'],
                          color: Colors.blue),
                    ]);
                  } else if (type == 'year') {
                    int month = dateTime.month;
                    chartData[month - 1] =
                        BarChartGroupData(x: month - 1, barRods: [
                      BarChartRodData(
                          toY: chartData[month - 1].barRods[0].toY +
                              data['distance'],
                          color: Colors.blue),
                    ]);
                  }
                }

                averageDuration = calculateAverageDuration(totalPace);

                return Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 50, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        totalDistance.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        unit == 'km' ? '킬로미터' : '마일',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  runningTimes.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '러닝',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(averageDuration.inMinutes % 60).toString()}\'${(averageDuration.inSeconds % 60).toString().padLeft(2, '0')}"',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '평균 페이스',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  totalWorkoutTime.inHours.toString() == '0'
                                      ? '${(totalWorkoutTime.inMinutes % 60).toString().padLeft(2, '0')}:${(totalWorkoutTime.inSeconds % 60).toString().padLeft(2, '0')}'
                                      : '${totalWorkoutTime.inHours}:${(totalWorkoutTime.inMinutes % 60).toString().padLeft(2, '0')}:${(totalWorkoutTime.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '시간',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
