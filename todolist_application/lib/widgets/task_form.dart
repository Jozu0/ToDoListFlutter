import 'package:flutter/material.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/widgets/date_time_selection.dart'; // ta fonction selectDateAndTime
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final DateTime? dateTimeController;
  final void Function(DateTime)? onDateChanged;
  final VoidCallback onSubmit;

  TaskForm({
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.dateTimeController,
    this.onDateChanged,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.dateTimeController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        color: AppColors.cardBackground,
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: widget.nameController,
                    style: TextStyle(color: AppColors.text),
                    decoration: InputDecoration(
                      hintText: 'Enter a task name*',
                      hintStyle: TextStyle(color: AppColors.text),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: widget.descriptionController,
                    style: TextStyle(color: AppColors.text),
                    decoration: InputDecoration(
                      hintText: 'Enter a task description',
                      hintStyle: TextStyle(color: AppColors.text),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    // Pas de validation obligatoire ici
                    validator: (String? value) {
                      return null;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.square(50),
                      backgroundColor: AppColors.melon,
                    ),
                    onPressed: () async {
                      DateTime? picked = await selectDateAndTime(context);
                      if (picked != null) {
                        setState(() {
                          selectedDateTime = picked;
                        });
                        if (widget.onDateChanged != null) {
                          widget.onDateChanged!(picked);
                        }
                      }
                    },
                    child: Text(
                      "Select Date and Time",
                      style: TextStyle(color: AppColors.text, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    (selectedDateTime != null && selectedDateTime!.year >= 2000)
                        ? (selectedDateTime!.hour == 0 && selectedDateTime!.minute == 0
                            ? 'Due date: ${DateFormat('yyyy-MM-dd').format(selectedDateTime!)}'
                            : 'Due date: ${DateFormat('yyyy-MM-dd').format(selectedDateTime!)} '
                                '${(selectedDateTime!.hour % 12 == 0 ? 12 : selectedDateTime!.hour % 12).toString()}:'
                                '${selectedDateTime!.minute.toString().padLeft(2, '0')} '
                                '${selectedDateTime!.hour < 12 ? "AM" : "PM"}'
                          )
                        : 'No date selected',
                    style: TextStyle(color: AppColors.text, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              child: ElevatedButton(
                onPressed: widget.onSubmit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.square(60),
                  backgroundColor: AppColors.melon,
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: AppColors.text, fontSize: 23),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
