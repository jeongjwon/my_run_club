import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_run_club/screens/add_record_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();
  late DateTime _startOfMonth = DateTime(now.year, now.month, 1);
  late DateTime _endOfMonth =
      DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

  late TabController _tabController;

  final List<Tab> periods = <Tab>[
    const Tab(text: '주'),
    const Tab(text: '월'),
    const Tab(text: '년'),
    const Tab(text: '전체'),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
    _calculateDateRange();
  }

  void _calculateDateRange() {
    DateTime now = DateTime.now();
    _startOfMonth = DateTime(now.year, now.month, 1);
    _endOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
  }

  Duration calculateAverageDuration(List<Duration> durations) {
    List<int> millisecondsList =
        durations.map((duration) => duration.inMilliseconds).toList();

    int averageMilliseconds =
        millisecondsList.reduce((a, b) => a + b) ~/ durations.length;

    return Duration(milliseconds: averageMilliseconds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        surfaceTintColor: const Color(0xFFB2B2B2),
        centerTitle: false,
        title: const Text(
          '활동',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddRecordScreen()));
            },
            icon: const Icon(Icons.add_rounded),
            color: Colors.black,
            iconSize: 35,
          )
        ],
      ),
      body: DefaultTabController(
          length: periods.length,
          child: Column(
            children: [
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F6F7),
                  border: Border.all(
                      color: const Color(0xFFE5E5E5),
                      width: 1.0 // 원하는 border 색 설정
                      ),

                  borderRadius: BorderRadius.circular(80.0), // 원하는 radius 설정
                ),
                child: TabBar(
                  tabs: periods,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: const Color(0xFF46cbff),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: const Color(0xFF8D8D8D),
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
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
                                isGreaterThanOrEqualTo:
                                    Timestamp.fromDate(_startOfMonth))
                            .where('date',
                                isLessThan: Timestamp.fromDate(_endOfMonth))
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<DocumentSnapshot> documents =
                                snapshot.data!.docs;

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

                              int hours =
                                  int.parse(data['workoutTime'].split(":")[0]);
                              int minutes =
                                  int.parse(data['workoutTime'].split(":")[1]);
                              int seconds =
                                  int.parse(data['workoutTime'].split(":")[2]);

                              totalWorkoutTime += Duration(
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds);

                              int paceMin = int.parse(
                                  data['avgPace'].toString().substring(0, 1));
                              int paceSec = int.parse(data['avgPace'].substring(
                                  data['avgPace'].indexOf("'") + 1,
                                  data['avgPace'].indexOf('"')));

                              totalPace.add(
                                  Duration(minutes: paceMin, seconds: paceSec));
                            }

                            averageDuration =
                                calculateAverageDuration(totalPace);

                            return Container(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 10, 50, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    totalDistance.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w800),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              totalWorkoutTime.inHours
                                                          .toString() ==
                                                      '0'
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
                    const Center(child: Text('월 탭의 내용')),
                    const Center(child: Text('년 탭의 내용')),
                    const Center(child: Text('전체 탭의 내용')),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('newRunning')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> data =
                              documents[index].data() as Map<String, dynamic>;

                          return Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
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
                                      data['name'].toString().substring(11)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                                            data['workoutTime'].split(":")[0] ==
                                                    '0'
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
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
