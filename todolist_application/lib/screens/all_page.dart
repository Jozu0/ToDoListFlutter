import 'package:flutter/material.dart';
import 'package:namer_app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/widgets/task_card.dart';


class AllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<TaskProvider>();

    // Filtrer les tâches en retard et non terminées
    return Center(
      child: Container(
        color: AppColors.generalBackground,
        padding: EdgeInsets.all(16.0),
        child: appState.tasks.isNotEmpty
          ? Column(
            children: appState.tasks.map((task) => TaskCard(task: task, taskColor: AppColors.periwinkle)).toList(),
            )
          : Column(
            children: [
              SizedBox(height: 15, width: double.infinity),
              Text(
                'Nothing to do.',
                  style: TextStyle(fontSize: 24, color: AppColors.text),
                ),
              ],
            ),
      ),
    );
  }
}
