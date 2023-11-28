import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_run_club/provider/add_provider.dart';
import 'package:my_run_club/provider/workoutTime_provider.dart';
import 'package:provider/provider.dart';

class WorkoutTimeScreen extends StatefulWidget {
  const WorkoutTimeScreen({super.key});

  @override
  State<WorkoutTimeScreen> createState() => _WorkoutTimeScreenState();
}

class _WorkoutTimeScreenState extends State<WorkoutTimeScreen> {
  late int selectedHour;
  late int selectedMin;
  late int selectedSec;

  @override
  void initState() {
    super.initState();
    AddProvider addProvider = Provider.of<AddProvider>(context, listen: false);
    selectedHour = addProvider.workoutHour;
    selectedMin = addProvider.workoutMin;
    selectedSec = addProvider.workoutSec;
  }

  @override
  Widget build(BuildContext context) {
    AddProvider addProvider = Provider.of<AddProvider>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 10, 50),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Text(
                '운동 시간',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    addProvider.updateWorkoutTime(
                      selectedHour,
                      selectedMin,
                      selectedSec,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('완료',
                      style: TextStyle(
                        color: Colors.black,
                      )))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButtonHideUnderline(
                child: Row(
                  children: [
                    DropdownButton2(
                      value: selectedHour,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedHour = value!;
                        });
                      },
                      items: List.generate(
                        24,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index시간',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedMin,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedMin = value!;
                        });
                      },
                      items: List.generate(
                        60,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index분',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedSec,
                      onChanged: (value) {
                        setState(() {
                          selectedSec = value!;
                        });
                      },
                      items: List.generate(
                        60,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index초',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
