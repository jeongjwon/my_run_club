import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime dateTime = DateTime.now();

  late String pickedDate = '2023.11.19 토요일 오후 07:40';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String getFormattedDateTimeDay() {
    String formattedDate = DateFormat('yyyy.MM.dd').format(selectedDate);

    String formattedTime = DateFormat('a h:mm', 'ko_KR').format(DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    ));
    String formattedDay = DateFormat('EEEE', 'ko_KR').format(selectedDate);

    String result = '$formattedDate $formattedDay $formattedTime';

    return result;
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    setState(() {
      selectedDate = DateTime(
        pickedDate!.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime!.hour,
        pickedTime.minute,
      );
      selectedTime = pickedTime;
    });
  }

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
                    Navigator.pop(context, {
                      'pickedDate': getFormattedDateTimeDay(),
                      'date': dateTime,
                      'time': selectedTime,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  subtitle: Text(
                    getFormattedDateTimeDay(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () => _selectDateAndTime(context),
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

  String formatDate(Timestamp timestamp, BuildContext context) {
    DateTime dateTime = timestamp.toDate();
    String dayOfWeek =
        DateFormat('EEEE', Localizations.localeOf(context).languageCode)
            .format(dateTime);
    String amPm = DateFormat('a').format(dateTime);
    String formattedTime =
        DateFormat('h:mm', Localizations.localeOf(context).languageCode)
            .format(dateTime);

    return '$dayOfWeek $amPm $formattedTime';
  }
}
