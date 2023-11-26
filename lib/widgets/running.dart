import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Running extends StatefulWidget {
  String name, unit, workoutTime, avgPace, paceUnit;
  double distance;
  Timestamp date;
  TimeOfDay time;
  bool isIndoor;

  Running({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.distance,
    required this.unit,
    required this.avgPace,
    required this.paceUnit,
    required this.workoutTime,
    required this.isIndoor,
  });

  @override
  State<Running> createState() => _RunningState();
}

class _RunningState extends State<Running> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
