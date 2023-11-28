import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_run_club/widgets/running.dart';

class TaskProvider extends ChangeNotifier {
  List<BarChartGroupData> _chartData = [];
  List<BarChartGroupData> get chartData => _chartData;

  set chartData(List<BarChartGroupData> newData) {
    _chartData = newData;
    notifyListeners();
  }

  final CollectionReference runnings =
      FirebaseFirestore.instance.collection('runnings');

  Stream<QuerySnapshot> getRunningStream() {
    return runnings.orderBy('date', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getRunningStandard(DateTime start, DateTime end) {
    return runnings
        .where('date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start),
            isLessThanOrEqualTo: Timestamp.fromDate(end))
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
          time: doc['time'],
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

  Future<void> updateTask(String id, Map<String, dynamic> updatedData) async {
    try {
      bool documentExists =
          await runnings.doc(id).get().then((doc) => doc.exists);

      if (documentExists) {
        await runnings.doc(id).update(updatedData);

        notifyListeners();
      } else {
        print('ID가 $id인 문서가 존재하지 않습니다.');
      }
    } catch (e) {
      print('작업 업데이트 중 오류 발생: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      bool documentExists =
          await runnings.doc(id).get().then((doc) => doc.exists);

      if (documentExists) {
        await runnings.doc(id).delete();

        // _runnings List에서도 삭제
        // _runnings.removeWhere((task) => task.id == id);

        notifyListeners();
      } else {
        print('ID가 $id인 문서가 존재하지 않습니다.');
      }
    } catch (e) {
      print('작업 삭제 중 오류 발생: $e');
    }
  }
}
