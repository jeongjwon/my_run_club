import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_run_club/screens/detail_screen.dart';
import 'package:provider/provider.dart';

import 'package:my_run_club/widgets/running.dart';
import 'package:my_run_club/provider/task_provider.dart';

class RecordsList extends StatelessWidget {
  const RecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Running> runningsList = taskProvider.runningsList;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: const BoxDecoration(color: Color(0XFFF5F5F5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '최근 활동',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: taskProvider.getRunningStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              data: data,
                              documentId: documents[index].id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(DateFormat('yyyy. MM. dd.')
                                  .format(data['date'].toDate())),
                              subtitle: Text(
                                  '${data['name'].toString().substring(11)} ${data['isIndoor'] ? '(실내)' : '(실외)'}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        double.parse(
                                                data['distance'].toString())
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        data['unit'],
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['avgPace'],
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text(
                                        '평균 페이스',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['workoutTime'].split(":")[0] == '0'
                                            ? '${data['workoutTime'].split(":")[1]}:${data['workoutTime'].split(":")[2]}'
                                            : data['workoutTime'],
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Text(
                                        '시간',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
