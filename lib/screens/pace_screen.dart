import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_run_club/provider/add_provider.dart';
import 'package:provider/provider.dart';

class PaceScreen extends StatefulWidget {
  const PaceScreen({super.key});

  @override
  State<PaceScreen> createState() => _PaceScreenState();
}

class _PaceScreenState extends State<PaceScreen> {
  late int selectedPaceMin;
  late int selectedPaceSec;
  late String selectedPaceUnit;

  @override
  void initState() {
    super.initState();

    AddProvider addProvider = Provider.of<AddProvider>(context, listen: false);
    selectedPaceMin = addProvider.paceMin;
    selectedPaceSec = addProvider.paceSec;
    selectedPaceUnit = addProvider.paceUnit;
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
                '페이스',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    addProvider.updatePace(
                      selectedPaceMin,
                      selectedPaceSec,
                      selectedPaceUnit,
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
                      value: selectedPaceMin,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedPaceMin = value!;
                        });
                      },
                      items: List.generate(
                        57, // 3부터 59까지 총 57개의 항목
                        (index) => DropdownMenuItem<int>(
                          value: index + 3, // 3부터 시작하도록 인덱스에 3을 더합니다.
                          child: Text(
                            '${index + 3}분',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedPaceSec,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedPaceSec = value!;
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
                    DropdownButton2(
                      value: selectedPaceUnit,
                      onChanged: (value) {
                        setState(() {
                          selectedPaceUnit = value.toString();
                        });
                      },
                      items: ['/km', '/mile']
                          .map((unit) => DropdownMenuItem<String>(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
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
