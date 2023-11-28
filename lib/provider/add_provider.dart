import 'package:flutter/material.dart';

class AddProvider with ChangeNotifier {
  //name
  String _name = '';

  String get name => _name;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  //date
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  DateTime get selectedDate => _date;
  TimeOfDay get selectedTime => _time;

  void updateSelectedDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  void updateSelectedTime(TimeOfDay newTime) {
    _time = newTime;
    notifyListeners();
  }

  //distance
  int _bigValue = 1;
  int _smallValue = 1;
  String _unit = "km";

  int get bigValue => _bigValue;
  int get smallValue => _smallValue;
  String get unit => _unit;

  set bigValue(int value) {
    _bigValue = value;
    notifyListeners();
  }

  set smallValue(int value) {
    _smallValue = value;
    notifyListeners();
  }

  set unit(String value) {
    _unit = value;
    notifyListeners();
  }

  void updateDistance(int bigValue, int smallValue, String unit) {
    _bigValue = bigValue;
    _smallValue = smallValue;
    _unit = unit;

    notifyListeners();
  }

//workoutTime
  int _workoutHour = 0;
  int _workoutMin = 0;
  int _workoutSec = 0;

  int get workoutHour => _workoutHour;
  int get workoutMin => _workoutMin;
  int get workoutSec => _workoutSec;

  set workoutHour(int value) {
    _workoutHour = value;
    notifyListeners();
  }

  set workoutMin(int value) {
    _workoutMin = value;
    notifyListeners();
  }

  set workoutSec(int value) {
    _workoutSec = value;
    notifyListeners();
  }

  void updateWorkoutTime(int workoutHour, int workoutMin, int workoutSec) {
    _workoutHour = workoutHour;
    _workoutMin = workoutMin;
    _workoutSec = workoutSec;

    notifyListeners();
  }

//pace
  int _paceMin = 3;
  int _paceSec = 0;
  String _paceUnit = '/km';

  int get paceMin => _paceMin;
  int get paceSec => _paceSec;
  String get paceUnit => _paceUnit;

  set paceMin(int value) {
    _paceMin = value;
    notifyListeners();
  }

  set paceSec(int value) {
    _paceSec = value;
    notifyListeners();
  }

  set paceUnit(String value) {
    _paceUnit = value;
    notifyListeners();
  }

  void updatePace(int paceMin, int paceSec, String paceUnit) {
    _paceMin = paceMin;
    _paceSec = paceSec;
    _paceUnit = paceUnit;

    notifyListeners();
  }

//isIndoor
  bool _isIndoor = false;

  bool get isIndoor => _isIndoor;

  set isIndoor(bool value) {
    _isIndoor = value;
    notifyListeners();
  }

  void updateIsIndoor(bool isIndoor) {
    _isIndoor = isIndoor;

    notifyListeners();
  }
}
