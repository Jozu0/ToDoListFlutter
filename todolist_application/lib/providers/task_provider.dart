import 'package:flutter/material.dart';
import 'package:namer_app/models/task.dart';
import 'package:namer_app/models/task_status.dart';
import 'dart:async';


class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  Timer? timer;

  TaskProvider() {
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      for (var task in tasks) {
        task.status = getTaskStatus(task.plannedTime);
      }
      notifyListeners(); // Rafraîchit l'UI
    });
  }

  TaskStatus getTaskStatus(DateTime? plannedTime) {
    if (plannedTime == null || plannedTime.year < 2000) {
      return TaskStatus.notPlanned;
    }

    final now = DateTime.now();

    if (plannedTime.isBefore(now) && (plannedTime.hour!=0 || plannedTime.minute!=0)) {
      return TaskStatus.plannedLate;
    }

    if (plannedTime.year == now.year &&
        plannedTime.month == now.month &&
        plannedTime.day == now.day) {
      return TaskStatus.plannedForToday;
    }

    return TaskStatus.planned;
  }

  void deleteTask(Task task){
    tasks.remove(task);
    notifyListeners();
  }

  void addTask(String title, String desc, DateTime plannedTime) {
    final status = getTaskStatus(plannedTime);
    tasks.add(Task(title: title, desc: desc, plannedTime: plannedTime, status: status ));
    notifyListeners();
  }

  void toggleDone(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }


}