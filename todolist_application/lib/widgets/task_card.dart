import 'package:flutter/material.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/providers/task_provider.dart';


class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.taskColor,
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  final Color taskColor;
  
  @override
  Widget build(BuildContext context) {
  var appStateProvider = context.watch<TaskProvider>();
  final Color cardColor = task.isDone 
        ? Color.lerp(taskColor, Colors.grey.shade300, 0.5)!// couleur quand la tâche est finie
        : taskColor;   


    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(5),
          child: ListTile(
            title: 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_month, color:AppColors.text),
                  SizedBox(width:5),
                  if(task.plannedTime.year>2024)
                  Text(task.formattedDateTime, style: TextStyle(color: AppColors.text, fontSize: 16))
                  else
                  Text('No date'),
                  SizedBox(width:12),
                  Icon(Icons.alarm, color:AppColors.text),
                  SizedBox(width:5),
                  if(task.plannedTime.hour == 0 && task.plannedTime.minute==0)
                  Text('No hour')
                  else
                  Text(task.formattedHourTime, style: TextStyle(color: AppColors.text, fontSize: 16))
                ]
              ),
            subtitle: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: TextStyle(color: AppColors.text, fontSize: 24)),
                  Text(task.desc),
                ]
              ),
            leading: 
              IconButton(
                 icon: Icon(
                    task.isDone ? Icons.check_circle : Icons.circle_outlined,
                    color: AppColors.text,
                  ),
                onPressed: () {
                  appStateProvider.toggleDone(task);
                },
            ),
            trailing:
              IconButton(
                onPressed: () {
                  appStateProvider.deleteTask(task);
                },
                icon: Icon(Icons.delete_sweep))
        )
      )
    );
  }
}
