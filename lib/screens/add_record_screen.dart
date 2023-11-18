import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_run_club/screens/distance_screen.dart';
import 'package:my_run_club/screens/pace_screen.dart';
import 'package:my_run_club/screens/time_screen.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  bool nameEditing = false;
  bool dateEditing = false;
  bool distanceEditing = false;
  bool timeEditing = false;
  bool paceEditing = false;

  String newRunningName = "";
  String totalDistance = "";
  String workoutTime = "";
  String paceTime = "";
  bool indoor = false;
  final TextEditingController _nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final String _nameText = "";

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
                TextButton(
                  onPressed: () {
                    {}
                  },
                  child: Text(
                    !nameEditing ? '편집' : 'ddfa',
                    style: const TextStyle(color: Color(0xFF8D8D8D)),
                  ),
                )
              ],
            ),
          ),
          Container(
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
                TextButton(onPressed: () {}, child: const Text('편집'))
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
                        String combinedString = result as String;
                        totalDistance = combinedString;
                        setState(() {
                          distanceEditing = true;
                        });
                      }
                    });
                  },
                  child: Text(
                    !distanceEditing ? '편집' : totalDistance,
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
                          String combinedString = result as String;
                          workoutTime = combinedString;
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
                          String combinedString = result as String;
                          paceTime = combinedString;
                          setState(() {
                            paceEditing = true;
                          });
                        }
                      });
                    },
                    child: Text(
                      !paceEditing ? '편집' : paceTime,
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
              color: dateEditing &&
                      nameEditing &&
                      distanceEditing &&
                      timeEditing &&
                      paceEditing
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
                    // 저장 버튼을 눌렀을 때의 동작 구현
                    // 예를 들어, 저장 로직을 추가할 수 있습니다.
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
