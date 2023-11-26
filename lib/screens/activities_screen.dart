import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:my_run_club/screens/add_record_screen.dart';
import 'package:my_run_club/widgets/weekly_summary.dart';
import 'package:my_run_club/widgets/monthly_summary.dart';
import 'package:my_run_club/widgets/yearly_summary.dart';

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
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  color: Colors.white,
                  border:
                      Border.all(color: const Color(0xFFE5E5E5), width: 1.2),
                  borderRadius: BorderRadius.circular(80.0),
                ),
                child: TabBar(
                  tabs: periods,
                  controller: _tabController,
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
                  controller: _tabController,
                  children: const [
                    SingleChildScrollView(child: WeeklySummary()),

                    SingleChildScrollView(child: MonthlySummary()),
                    SingleChildScrollView(child: YearlySummary()),
                    // Center(
                    //   child: Text('전체 탭의 내용'),
                    // ),
                    Center(
                      child: Text('전체 탭의 내용'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

List<BarChartGroupData> generateBarChartData() {
  List<double> weeklyData = [5, 8, 6, 4, 7, 9, 10];

  List<BarChartGroupData> barChartData = [];
  for (int i = 0; i < weeklyData.length; i++) {
    barChartData.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: 0,
            fromY: weeklyData[i],
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  return barChartData;
}
