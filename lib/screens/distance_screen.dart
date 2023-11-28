import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_run_club/provider/add_provider.dart';
import 'package:my_run_club/provider/distance_provider.dart';
import 'package:provider/provider.dart';

class DistanceScreen extends StatefulWidget {
  const DistanceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DistanceScreen> createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  late int selectedBigValue;
  late int selectedSmallValue;
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    AddProvider addProvider = Provider.of<AddProvider>(context, listen: false);
    selectedBigValue = addProvider.bigValue;
    selectedSmallValue = addProvider.smallValue;
    selectedUnit = addProvider.unit;
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
                '거리',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    addProvider.updateDistance(
                      selectedBigValue,
                      selectedSmallValue,
                      selectedUnit,
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
