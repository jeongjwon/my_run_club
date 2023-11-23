import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_run_club/widgets/running.dart';

class TaskProvider extends ChangeNotifier {
  final CollectionReference runnings =
      FirebaseFirestore.instance.collection('newRunning');

  Stream<QuerySnapshot> getRunningStream() {
    return runnings.orderBy('date', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getRunningStandard(DateTime start, DateTime end) {
    return runnings
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            isLessThan: Timestamp.fromDate(end))
        .snapshots();
  }

  final List<Running> _runnings = [];

  List<Running> get runningsList => _runnings;

  Future<void> fetchRunnings() async {
    try {
      QuerySnapshot querySnapshot = await runnings.get();
      _runnings.clear();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Running running = Running(
          name: doc['name'],
          date: doc['date'],
          distance: doc['distance'],
          unit: doc['unit'],
          avgPace: doc['avgPace'],
          paceUnit: doc['paceUnit'],
          workoutTime: doc['workoutTime'],
          isIndoor: doc['isIndoor'],
        );

        _runnings.add(running);
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching runnings: $e');
    }
  }

  Future<void> addTask(Running task) async {
    await runnings.add({
      'name': task.name,
      'date': task.date,
      'distance': task.distance,
      'unit': task.unit,
      'avgPace': task.avgPace,
      'paceUnit': task.paceUnit,
      'workoutTime': task.workoutTime,
      'isIndoor': task.isIndoor,
    });
    _runnings.add(task);
    notifyListeners();
  }

  // void addTaskForDate(DateTime date, TaskWidget task) {
  //   if (!_tasksByDate.containsKey(date)) {
  //     _tasksByDate[date] = [];
  //   }

  //   _tasksByDate[date]!.add(task);
  //   notifyListeners();
  // }

  // void deleteTaskForDate(DateTime date, TaskWidget task) {
  //   if (_tasksByDate.containsKey(date) && _tasksByDate[date]!.contains(task)) {
  //     _tasksByDate[date]!.remove(task);
  //     notifyListeners();
  //   }
  // }
}
