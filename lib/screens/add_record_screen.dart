import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_run_club/screens/date_screen.dart';
import 'package:my_run_club/screens/distance_screen.dart';
import 'package:my_run_club/screens/pace_screen.dart';
import 'package:my_run_club/screens/time_screen.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  bool dateEditing = false;
  bool distanceEditing = false;
  bool timeEditing = false;
  bool paceEditing = false;

  String newRunningName = "";
  DateTime runningDate = DateTime.now();
  // Timestamp runningDate = Timestamp.fromDate(DateTime.now());
  double totalDistance = 0.0;
  String distanceUnit = "";
  String workoutTime = "";
  String avgPace = "";
  String paceUnit = "";
  bool indoor = false;

  final TextEditingController _nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final String _nameText = "";

  String selectedDate =
      '2023.11.19'; // You can initialize it with the current date
  String selectedTime = '19:13'; // You can initialize it with the current time

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          '러닝 추가',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  )))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('이름'),
                Text(
                  newRunningName,
                  style: const TextStyle(color: Color(0xFF8D8D8D)),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('날짜'),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const DateScreen(),
                        )),
                        isScrollControlled: true,
                      ).then((result) {
                        if (result != null) {
                          setState(() {
                            runningDate = result['dateTime'];
                            newRunningName =
                                '${result['combinedString'].toString().substring(0, 17)} 러닝';

                            setState(() {
                              dateEditing = true;
                            });
                          });
                        }
                      });
                    },
                    child: Text(
                      !dateEditing ? '편집' : newRunningName,
                      style: const TextStyle(color: Color(0xFF8D8D8D)),
                    ))
              ],
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('거리'),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const DistanceScreen(),
                      )),
                      isScrollControlled: true,
                    ).then((result) {
                      if (result != null) {
                        totalDistance = result['totalDistance'];
                        distanceUnit = result['selectedUnit'];

                        setState(() {
                          distanceEditing = true;
                        });
                      }
                    });
                  },
                  child: Text(
                    !distanceEditing
                        ? '편집'
                        : '${totalDistance.toString()} $distanceUnit',
                    style: const TextStyle(color: Color(0xFF8D8D8D)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('운동 시간'),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const TimeScreen(),
                        )),
                        isScrollControlled: true,
                      ).then((result) {
                        if (result != null) {
                          workoutTime =
                              '${result['timeHour'].toString()}:${result['timeMin'].toString().padLeft(2, '0')}:${result['timeSec'].toString().padLeft(2, '0')}';
                          setState(() {
                            timeEditing = true;
                          });
                        }
                      });
                    },
                    child: Text(
                      !timeEditing ? '편집' : workoutTime,
                      style: const TextStyle(color: Color(0xFF8D8D8D)),
                    ))
              ],
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('페이스'),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const PaceScreen(),
                        )),
                        isScrollControlled: true,
                      ).then((result) {
                        if (result != null) {
                          avgPace =
                              '${result['paceMin'].toString()}\'${result['paceSec'].toString().padLeft(2, '0')}"';
                          paceUnit = result['paceUnit'];
                          setState(() {
                            paceEditing = true;
                          });
                        }
                      });
                    },
                    child: Text(
                      !paceEditing ? '편집' : '$avgPace$paceUnit',
                      style: const TextStyle(color: Color(0xFF8D8D8D)),
                    ))
              ],
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('실내'),
                CupertinoSwitch(
                  value: indoor,
                  activeColor: const Color(0xFF34C759),
                  onChanged: (bool? value) {
                    setState(() {
                      indoor = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 40),
            height: 60,
            decoration: BoxDecoration(
              color:
                  dateEditing && distanceEditing && timeEditing && paceEditing
                      ? Colors.black
                      : const Color(0xFFBCBCBC),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    createDoc(newRunningName, runningDate, totalDistance,
                        distanceUnit, workoutTime, avgPace, paceUnit, indoor);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '저장',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void createDoc(
      String newRunningName,
      DateTime runningDate,
      double totalDistance,
      String distanceUnit,
      String workoutTime,
      String avgPace,
      String paceUnit,
      bool indoor) {
    db.collection('newRunning').add({
      'name': newRunningName,
      'date': Timestamp.fromDate(runningDate),
      'distance': totalDistance,
      'unit': distanceUnit,
      'workoutTime': workoutTime,
      'avgPace': avgPace,
      'paceUnit': paceUnit,
      'indoor': indoor,
    });
  }
}
