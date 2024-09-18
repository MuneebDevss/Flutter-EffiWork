import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/to_do_controller.dart';

class NormalToDoCard extends StatefulWidget {
  const NormalToDoCard({
    super.key,
    required this.toDos,
    required this.checkBoxSelected,
    required this.controller,
  });

  final NormalTodo toDos;
  final ToDoController controller;
  final bool checkBoxSelected;
  @override
  State<NormalToDoCard> createState() => _NormalToDoCardState();
}

class _NormalToDoCardState extends State<NormalToDoCard> {
  double width = 341;
  @override
  void initState() {
    width = widget.checkBoxSelected ? width - 50 : width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      onDragStarted: () {
        widget.controller.dragStarted(context);
      },
      feedback: const Icon(Icons.insert_emoticon),
      data: widget.toDos,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      child: Container(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: widget.toDos.task, style: const TextStyle()),
            ]))
          ],
        ),
      ),
    );
  }
}
