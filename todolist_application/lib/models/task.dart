import 'package:namer_app/models/task_status.dart';

class Task {
  final String title;
  final String desc;
  final DateTime plannedTime;
  final String formattedDateTime;
  final String formattedHourTime;
  bool isDone;
  TaskStatus status;

  Task({
    required this.title,
    required this.desc,
    required this.plannedTime,
    this.status = TaskStatus.notPlanned,
    this.isDone = false,
  }): formattedDateTime = "${plannedTime.day}/${plannedTime.month}/${plannedTime.year}",
      formattedHourTime = 
        "${plannedTime.hour % 12 == 0 ? 12 : plannedTime.hour % 12}"
        ":${plannedTime.minute.toString().padLeft(2, '0')}"
        " ${plannedTime.hour < 12 ? "AM" : "PM"}";
}

