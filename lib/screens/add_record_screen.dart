import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_run_club/provider/add_provider.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_run_club/provider/task_provider.dart';
import 'package:my_run_club/screens/date_screen.dart';
import 'package:my_run_club/screens/distance_screen.dart';
import 'package:my_run_club/screens/pace_screen.dart';
import 'package:my_run_club/screens/workoutTime_screen.dart';
import 'package:my_run_club/widgets/running.dart';

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
  double totalDistance = 0.0;
  String distanceUnit = "";
  String workoutTime = "";
  String avgPace = "";
  String paceUnit = "";
  late bool isIndoor;

  TimeOfDay runningTime = TimeOfDay.now();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    AddProvider addProvider = Provider.of<AddProvider>(context, listen: false);

    isIndoor = addProvider.isIndoor;
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    AddProvider addProvider = Provider.of<AddProvider>(context);

    String id = (taskProvider.runningsList.length + 1).toString();

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
                  !dateEditing
                      ? ''
                      : '${newRunningName.split(" ")[1]} ${newRunningName.split(" ")[2]} 러닝  ',
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
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const DateScreen(),
                        )),
                        isScrollControlled: true,
                      );

                      setState(() {
                        dateEditing = true;
                        runningDate = addProvider.selectedDate;
                        runningTime = addProvider.selectedTime;
                        newRunningName = addProvider.name;
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
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const DistanceScreen(),
                      )),
                      isScrollControlled: true,
                    );

                    setState(() {
                      distanceEditing = true;
                      totalDistance = addProvider.bigValue.toDouble() +
                          addProvider.smallValue.toDouble() / 100;
                    });
                  },
                  child: Text(
                    !distanceEditing
                        ? '편집'
                        : '${addProvider.bigValue}.${addProvider.smallValue} ${addProvider.unit}',
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
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const WorkoutTimeScreen(),
                        )),
                        isScrollControlled: true,
                      );
                      setState(() {
                        timeEditing = true;

                        workoutTime = workoutTime =
                            '${addProvider.workoutHour.toString()}:${addProvider.workoutMin.toString().padLeft(2, '0')}:${addProvider.workoutSec.toString().padLeft(2, '0')}';
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
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const PaceScreen(),
                        )),
                        isScrollControlled: true,
                      );
                      setState(() {
                        paceEditing = true;
                        avgPace =
                            '${addProvider.paceMin}\'${addProvider.paceSec.toString().padLeft(2, '0')}"';
                        paceUnit = addProvider.paceUnit;
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
                  value: isIndoor,
                  activeColor: const Color(0xFF34C759),
                  onChanged: (bool? value) {
                    setState(() {
                      isIndoor = value ?? false;
                    });
                    addProvider.updateIsIndoor(isIndoor);
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
                    Provider.of<TaskProvider>(context, listen: false).addTask(
                        id,
                        Running(
                            name: newRunningName,
                            date: Timestamp.fromDate(runningDate),
                            time: runningTime,
                            distance: totalDistance,
                            unit: distanceUnit,
                            avgPace: avgPace,
                            paceUnit: paceUnit,
                            workoutTime: workoutTime,
                            isIndoor: isIndoor));

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
}
