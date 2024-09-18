import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/item_oriented_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/BusinessLogic/to_do_blocs.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/to_do_controller.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/widgets/item_oriented_to_do_card.dart';

class ItemOrientedTasks extends StatefulWidget {
  const ItemOrientedTasks({
    super.key,
    required this.controller,
  });

  final ToDoController controller;

  @override
  State<ItemOrientedTasks> createState() => _ItemOrientedTasksState();
}

class _ItemOrientedTasksState extends State<ItemOrientedTasks> {
  @override
  void initState() {
    context.read<ToDoBloc>().add(RetrieveEvent(type: 'ItemOrientedTasks'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoBloc, ToDosState>(
      builder: (BuildContext context, ToDosState state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }
        if (widget.controller.items.isEmpty) {
          return const Center(
              child: Text('You do not have any Items In this Category Yet'));
        } else {
          return ListView.builder(
              itemCount: widget.controller.items.length,
              itemBuilder: (context, index) {
                ItemOrientedTodo toDos =
                    (widget.controller.items[index] as ItemOrientedTodo);
                String currentItemDate = widget.controller.getDate(index);
                String previousItemDate = widget.controller.getDate(index - 1);
                String currentItemTime = widget.controller.getTime(index);
                String previousItemTime = widget.controller.getTime(index - 1);
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
                      ValueListenableBuilder(
                        valueListenable: widget.controller.isCheckBoxselected,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          if (value) {
                            return Row(
                              children: [
                                Checkbox(
                                    value:
                                        widget.controller.isItemSelected(toDos),
                                    onChanged: (value) {
                                      widget.controller
                                          .manageCheckBox(value, toDos);
                                    }),
                                Expanded(
                                    child: ItemToDoCard(
                                  toDos: toDos,
                                  checkBoxSelected: value,
                                  controller: widget.controller,
                                )),
                              ],
                            );
                          } else {
                            return ItemToDoCard(
                              toDos: toDos,
                              checkBoxSelected: value,
                              controller: widget.controller,
                            );
                          }
                        },
                      )
                    ],
                  ),
                );
              });
        }
      },
      listener: (BuildContext context, ToDosState state) {
        if (state is RetrievedState) {
          widget.controller.items = state.toDos;
        }
        if (state is FailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is RemovedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
