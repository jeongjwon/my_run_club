import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/screens/add_record_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with TickerProviderStateMixin {
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
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
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
                    Center(
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('newRunning')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                    documents[index].data()
                                        as Map<String, dynamic>;
                                return Container(
                                  padding: const EdgeInsets.all(3),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            '${data['date'].toString() == DateTime.now().toString() ? '오늘' : data['date']}'),
                                        subtitle: Text('${data['name']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['distance']
                                                      .toString()
                                                      .substring(
                                                          0,
                                                          data['distance']
                                                                  .toString()
                                                                  .length -
                                                              2),
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  '${data['distance'].replaceAll(RegExp('[0-9.]'), '')}',
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
                                                  '${data['avgPace'].toString().split(" ")[0].substring(0, 1)}\'${data['avgPace'].toString().split(" ")[1].substring(0, 2)}"',
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
                                                  data['workouTime']
                                                              .toString()
                                                              .substring(
                                                                  0, 1) ==
                                                          '0'
                                                      ? '${data['workouTime'].toString().split(" ")[1].substring(0, 2)}:${data['workouTime'].toString().split(" ")[2].substring(0, 2)}'
                                                      : '${data['workouTime'].toString().split(" ")[0].substring(0, 2)}:${data['workouTime'].toString().split(" ")[1].substring(0, 2)}:${data['workouTime'].toString().split(" ")[2].substring(0, 2)}',
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
                    const Center(child: Text('월 탭의 내용')),
                    const Center(child: Text('년 탭의 내용')),
                    const Center(child: Text('전체 탭의 내용')),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
