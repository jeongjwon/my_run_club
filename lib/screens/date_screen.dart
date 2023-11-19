import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  String selectedDate =
      '2023.11.19'; // You can initialize it with the current date
  int selectedTimeHour = DateTime.now().hour;
  int selectedTimeMin = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 10, 50),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              const Text(
                '날짜',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    String combinedString =
                        '$selectedDate ${selectedTimeHour.toString().padLeft(2, '0')}:${selectedTimeMin.toString().padLeft(2, '0')}';
                    Navigator.pop(context, combinedString);
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
              Expanded(
                child: ListTile(
                  subtitle: Text(
                    selectedDate,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2024),
                    );
                    if (picked != DateTime.now()) {
                      setState(() {
                        selectedDate =
                            "${picked?.year}.${picked?.month}.${picked?.day}";
                      });
                    } else {
                      setState(() {
                        selectedDate = DateTime.now().toString();
                      });
                    }
                  },
                ),
              ),
              DropdownButtonHideUnderline(
                child: Row(
                  children: [
                    DropdownButton2(
                      value: selectedTimeHour,
                      isExpanded: false,
                      onChanged: (value) {
                        setState(() {
                          selectedTimeHour = value!;
                        });
                      },
                      items: List.generate(
                        24,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            index < 10 ? '0$index' : '$index',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DropdownButton2(
                      value: selectedTimeMin,
                      onChanged: (value) {
                        setState(() {
                          selectedTimeMin = value!;
                        });
                      },
                      items: List.generate(
                        60,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            index < 10 ? '0$index' : '$index',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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