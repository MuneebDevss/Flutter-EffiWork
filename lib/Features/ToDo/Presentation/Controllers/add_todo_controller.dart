import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';

class AddTodoController {
  final List<NormalTodo> toDo;
  DateTime? time;
  String task = '';
  TextEditingController textController = TextEditingController();
  AddTodoController({required this.toDo});
  Future<void> showDateTime(BuildContext context) async {
    DateTime firstDate = DateTime.now();
    DateTime lastTime = firstDate.add(const Duration(days: 365 * 10));

    time = (await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        firstDate: DateTime.now(),
        lastDate: lastTime))!;
    if (time != null) {
      print(time);
    }
  }

  void addTask() {}
}
