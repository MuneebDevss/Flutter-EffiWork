import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Controllers/to_do_controller.dart';
import 'package:where_is_my_stuff/Features/ToDo/Presentation/Pages/item_oriented_todo_page.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ToDoController controller = ToDoController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    controller.sortTheListByTime();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFD0BCFF),
          title: const Text('To Dos'),
          actions: [
            IconButton(
              onPressed: () {
                controller.checkActionTapped();
                setState(() {});
              },
              icon: const Icon(Icons.check),
            ),
            if (controller.isCheckBoxselected.value)
              IconButton(
                onPressed: () {
                  controller.deleteActionTapped(context);
                },
                icon: const Icon(Icons.delete_forever),
              ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text('Items oriented'),
              ),
              Tab(
                child: Text('Normal task'),
              )
            ],
          )),
      body: TabBarView(children: [
        ItemOrientedTasks(controller: controller),
      ]),
    );
  }
}



