import 'package:flutter/cupertino.dart';

class Record extends StatefulWidget {
  String name, date, distance, workoutTime, avgPace;
  bool indoor;

  Record({
    super.key,
    required this.name,
    required this.date,
    required this.distance,
    required this.workoutTime,
    required this.avgPace,
    required this.indoor,
  });

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
