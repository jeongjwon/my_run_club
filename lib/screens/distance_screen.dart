import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DistanceScreen extends StatefulWidget {
  const DistanceScreen({super.key});

  @override
  State<DistanceScreen> createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  int selectedBigValue = 1;
  int selectedSmallValue = 1;
  String selectedUnit = "km";
  double totalDistance = 0.0;

  @override
  Widget build(BuildContext context) {
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
                '거리',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    double.parse('$selectedBigValue.$selectedSmallValue');
                    Navigator.pop(context, {
                      // 'totalDistance': totalDistance,
                      'selectedBigValue': selectedBigValue,
                      'selectedSmallValue': selectedSmallValue,
                      'selectedUnit': selectedUnit
                    });
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
                      value: selectedBigValue,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedBigValue = value!;
                        });
                      },
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedSmallValue,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedSmallValue = value!;
                        });
                      },
                      items: List.generate(
                        100,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedUnit,
                      onChanged: (value) {
                        setState(() {
                          selectedUnit = value.toString();
                        });
                      },
                      items: ['km', 'mile']
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
