import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Running extends StatefulWidget {
  String name, unit, workoutTime, avgPace, paceUnit;
  double distance;
  Timestamp date;
  TimeOfDay time;
  bool isIndoor;
  int? strength;
  String? place;
  String? memo;

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
    this.strength,
    this.place,
    this.memo,
  });
  void setStrength(int value) {
    strength = value;
  }

  void setPlace(String value) {
    place = value;
  }

  void setMemo(String value) {
    memo = value;
  }

  factory Running.fromMap(Map<String, dynamic> map) {
    TimeOfDay timeOfDayFromJson(String json) {
      List<String> parts = json.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    return Running(
      name: map['name'],
      date: map['date'],
      time: map['time'] != null
          ? timeOfDayFromJson(map['time'])
          : TimeOfDay.now(), // 기본값 설정

      distance: map['distance'],
      unit: map['unit'],
      avgPace: map['avgPace'],
      paceUnit: map['paceUnit'],
      workoutTime: map['workoutTime'],
      isIndoor: map['isIndoor'],
      strength: map['strength'],
      place: map['place'],
      memo: map['memo'],
    );
  }
  @override
  State<Running> createState() => _RunningState();
}

class _RunningState extends State<Running> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
