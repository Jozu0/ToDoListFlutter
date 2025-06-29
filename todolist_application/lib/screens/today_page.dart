import 'package:flutter/material.dart';
import 'package:namer_app/models/task_status.dart';
import 'package:namer_app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/widgets/task_card.dart';


class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<TaskProvider>();

    // Filtrer les tâches en retard et non terminées
    final todayTasks = appState.tasks.where(
      (t) => t.status == TaskStatus.plannedForToday
    ).toList();

    return Center(
      child: Container(
        color: AppColors.generalBackground,
        padding: EdgeInsets.all(16.0),
        child: todayTasks.isNotEmpty
          ? Column(
            children: todayTasks.map((task) => TaskCard(task: task, taskColor: AppColors.pink,)).toList(),
            )
          : Column(
            children: [
              SizedBox(height: 15, width: double.infinity),
              Text(
                'No task for today.',
                  style: TextStyle(fontSize: 24, color: AppColors.text),
                ),
              ],
            ),
      ),
    );
  }
}
