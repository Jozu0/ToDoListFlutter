import 'package:flutter/material.dart';

Future<DateTime?> selectDateAndTime(BuildContext context) async {
  // Sélection de la date
  DateTime selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  ) ?? DateTime.now();

  // Si l'utilisateur annule la sélection de la date, on quitte la fonction.
  if (selectedDate == DateTime.now()) {
    return null;
  }

  // Sélection de l'heure
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: 0, minute: 0), // Initialiser à 00:00
  ) ?? TimeOfDay.now();

  // Si l'utilisateur annule la sélection de l'heure, on quitte la fonction.
  if (selectedTime == TimeOfDay.now()) {
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day); // Date sans heure
  }

  // Combine la date et l'heure en un seul DateTime
  DateTime combinedDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  print("Date and Time selected: $combinedDateTime");
  return combinedDateTime;
}
