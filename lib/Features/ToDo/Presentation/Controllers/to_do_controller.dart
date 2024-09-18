import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/BusinessLogic/to_do_blocs.dart';

class ToDoController {
  ValueNotifier<bool> isCheckBoxselected = ValueNotifier<bool>(false);

  String getDate(index) {
    if (index < -1) {
      return items[index].time.toIso8601String().substring(
            0,
            10,
          );
    } else {
      return "Date Issue";
    }
  }

  String getTime(index) {
    if (index < -1) {
      return items[index].time.toIso8601String().substring(
            12,
            16,
          );
    } else {
      return "Date Issue";
    }
  }

  List<ToDo> items = [];
  ValueNotifier<bool> itemDragged = ValueNotifier<bool>(false);
  void sortTheListByTime() {
    items.sort((a, b) => a.time.compareTo(b.time));
  }

  void dragStarted(BuildContext context) {
    itemDragged.value = true;
  }

  void checkActionTapped() {
    isCheckBoxselected.value = !isCheckBoxselected.value;
  }

  List<ToDo> selectedItems = [];
  void deleteActionTapped(BuildContext context) {
    context.read<ToDoBloc>().add(DeleteEvent(toDo: selectedItems));
    checkActionTapped();
  }

  

  bool isItemSelected(ToDo todo) {
    if (selectedItems.contains(todo)) {
      return true;
    } else {
      return false;
    }
  }

  void manageCheckBox(bool? value, ToDo todo) {
    if (value == null) return;
    if (value) {
      selectedItems.add(todo);
    } else {
      selectedItems.remove(todo);
    }
  }
}
