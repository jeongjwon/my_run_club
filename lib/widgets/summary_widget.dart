import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryWidget extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  final Duration Function(List<Duration>) calculateAverageDuration;

  const SummaryWidget({
    super.key,
    required this.start,
    required this.end,
    required this.calculateAverageDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('newRunning')
                .where('date',
                    isGreaterThanOrEqualTo: Timestamp.fromDate(start))
                .where('date', isLessThan: Timestamp.fromDate(end))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<DocumentSnapshot> documents = snapshot.data!.docs;

                double totalDistance = 0.0;
                Duration totalWorkoutTime = const Duration();

                List<Duration> totalPace = [];
                Duration averageDuration = const Duration();

                String unit = "";
                int runningTimes = documents.length;

                for (var document in documents) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  double distance = data['distance'];
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
                                )
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
