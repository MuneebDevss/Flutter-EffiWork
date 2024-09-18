import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Features/ItemDescription/Presentaion/Pages/item_description.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/item_oriented_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/to_do_controller.dart';

class ItemToDoCard extends StatefulWidget {
  const ItemToDoCard({
    super.key,
    required this.toDos,
    required this.checkBoxSelected,
    required this.controller,
  });

  final ItemOrientedTodo toDos;
  final ToDoController controller;
  final bool checkBoxSelected;
  @override
  State<ItemToDoCard> createState() => _ItemToDoCardState();
}

class _ItemToDoCardState extends State<ItemToDoCard> {
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
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ItemDescription(item: (widget.toDos).items))),
        child: Container(
          padding: const EdgeInsets.all(Sizes.md),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: widget.toDos.task, style: const TextStyle()),
                const TextSpan(
                    text: "\nOn\n", style: TextStyle(color: Colors.pinkAccent)),
                TextSpan(
                    text: widget.toDos.items.name,
                    style: const TextStyle(color: Colors.pinkAccent)),
                const TextSpan(
                    text: "\nLocated At\n",
                    style: TextStyle(color: Colors.pinkAccent)),
                TextSpan(
                    text: widget.toDos.items.location,
                    style: const TextStyle(color: Colors.pinkAccent)),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
