import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/widgets/task_form.dart';
import 'package:namer_app/providers/task_provider.dart';
import 'package:provider/provider.dart';

Future<void> dialogBuilder(BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _plannedTime = DateTime(1950, 10, 9);

  void updatePlannedTime(DateTime newDate) {
    _plannedTime = newDate;
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      String taskName = _nameController.text;
      String taskDescription = _descriptionController.text;
      DateTime plannedTime = _plannedTime!;
      var appStateProvider = context.read<TaskProvider>();
      appStateProvider.addTask(taskName, taskDescription, plannedTime);
      Navigator.of(context).pop();
    }
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 800,
                height: 460,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: AppColors.generalBackground,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, -2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TaskForm(
                      formKey: _formKey,
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      dateTimeController: _plannedTime,
                      onDateChanged: updatePlannedTime,  // <-- callback pour date
                      onSubmit: submitForm,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
