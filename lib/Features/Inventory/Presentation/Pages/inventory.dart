import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';

import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Features/Category/Presentation/Pages/category_items.dart';
import 'package:where_is_my_stuff/Features/Inventory/Presentation/Controller/inventory_controller.dart';

class MyInventory extends StatefulWidget {
  const MyInventory({super.key});

  @override
  State<MyInventory> createState() => _MyInventoryState();
}

class _MyInventoryState extends State<MyInventory> {
  InventoryController categoryItemController = InventoryController();
  @override
  void initState() {
    context
        .read<ItemsBloc>()
        .add(RetrieveEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFD0BCFF),
          title: const Text('Inventory'),
          actions: [
            IconButton(
              onPressed: () {
                categoryItemController.checkActionTapped();
                setState(() {});
              },
              icon: const Icon(Icons.check),
            ),
            if (categoryItemController.isItemSelectable)
              IconButton(
                onPressed: () {
                  categoryItemController.deleteActionTapped(context);
                },
                icon: const Icon(Icons.delete_forever),
              ),
          ]),
      body: ListOfItems(categoryItemController: categoryItemController),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: categoryItemController.itemDragged,
        builder: (BuildContext context, bool value, Widget? child) {
          if (value) {
            return DragTarget<Item>(
              builder: (BuildContext context, List<Item?> candidateData,
                  List<dynamic> rejectedData) {
                return FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.delete_forever),
                );
              },
              onAcceptWithDetails: (details) {
                categoryItemController.deleteTheDraggedItem(
                    context, details.data);
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.inventoryController,
  });

  final InventoryController inventoryController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        focusNode: inventoryController.searchNode,
        onTapOutside: (value) {
          inventoryController.searchNode.unfocus();
        },
        onChanged: (value) {},
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}


