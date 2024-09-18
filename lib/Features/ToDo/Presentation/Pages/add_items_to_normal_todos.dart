import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/add_todo_controller.dart';

class AddItemsToNormalToDOs extends StatefulWidget {
  const AddItemsToNormalToDOs({super.key, required this.todos});
  final List<NormalTodo> todos;

  @override
  State<AddItemsToNormalToDOs> createState() => _AddItemsToNormalToDOsState();
}

class _AddItemsToNormalToDOsState extends State<AddItemsToNormalToDOs> {
  late final AddTodoController controller;
  @override
  void initState() {
    controller = AddTodoController(toDo: widget.todos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            const Text('Add the Task You want to do'),
            const SpaceBetweenItems(),
            TextField(
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus!.unfocus(),
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: 'Enter new value',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue, width: 2)),
              ),
            ),
            const SpaceBetweenItems(),
            Row(
              children: [
                const Text('Date:'),
                Text(controller.time?.toIso8601String() ??
                    DateTime.now().toIso8601String()),
                ElevatedButton.icon(
                    onPressed: () {
                      controller.showDateTime(context);
                    },
                    label: const Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
