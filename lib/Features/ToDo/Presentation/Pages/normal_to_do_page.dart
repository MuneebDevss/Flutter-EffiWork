import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/to_do_controller.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/widgets/normal_to_do_card.dart';

class NormaTasks extends StatelessWidget {
  const NormaTasks({
    super.key,
    required this.controller,
  });

  final ToDoController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          NormalTodo toDos = controller.items[index] as NormalTodo;
          String currentItemDate = controller.getDate(index);
          String previousItemDate = controller.getDate(index - 1);
          String currentItemTime = controller.getTime(index);
          String previousItemTime = controller.getTime(index - 1);
          return Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //first item should be printed without comparison
                if (index == 0)
                  Text(
                    "$currentItemDate $currentItemTime",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'SecularOne'),
                  ),
                if (index != 0)
                  if (currentItemDate != previousItemDate &&
                      currentItemTime == previousItemTime)
                    Text(
                      "$currentItemDate $currentItemTime",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'SecularOne'),
                    ),
                const SpaceBetweenItems(),
                NormalToDoCard(
                  checkBoxSelected: controller.isCheckBoxselected.value,
                  controller: controller, toDos: toDos,
                )
              ],
            ),
          );
        });
  }
}