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
                // 원하는 배경색으로 설정
                child: TabBar(
                  tabs: periods,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.blue,
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
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('주 탭의 내용')),
                    Center(child: Text('월 탭의 내용')),
                    Center(child: Text('년 탭의 내용')),
                    Center(child: Text('전체 탭의 내용')),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
