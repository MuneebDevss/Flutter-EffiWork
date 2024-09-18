import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/controller/Items_view_interface.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/Category/Presentation/CategoryController/category_item_controller.dart';

import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/widgets/item_thumbnail.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key, required this.category});
  final String category;
  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  CategoryItemController categoryItemController = CategoryItemController();
  @override
  void initState() {
    context
        .read<ItemsBloc>()
        .add(RetrieveByCategoryEvent(category: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFD0BCFF),
          title: Text(widget.category),
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

class ListOfItems extends StatelessWidget {
  const ListOfItems({
    super.key,
    required this.categoryItemController,
  });

  final ItemsViewInterface categoryItemController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemsBloc, ItemsState>(
      listener: (BuildContext context, ItemsState state) {
        if (state is RetrievedState) {
          categoryItemController.items = state.items;
        }
        if (state is RemovedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          //remove the selected items
          categoryItemController.items = List.from(categoryItemController.items
              .where((item) =>
                  !categoryItemController.selectedItems.contains(item)));
          categoryItemController.selectedItems.clear();
        }
        if (state is FailedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (BuildContext context, ItemsState state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (categoryItemController.items.isEmpty) {
          return const Center(
              child: Text('You do not have any Items In this Category Yet'));
        } else {
          return Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      focusNode: categoryItemController.searchNode,
                      onTapOutside: (value) {
                        categoryItemController.searchNode.unfocus();
                      },
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                      ))
                ],
              ),
              const SpaceBetweenSections(),
              Expanded(
                child: Padding(
                  padding: categoryItemController.getPadding(),
                  child: ListView.builder(
                      itemCount: categoryItemController.items.length,
                      itemBuilder: (context, index) {
                        Item item = categoryItemController.items[index];
                        if (categoryItemController.isItemSelectable) {
                          return BlocBuilder<ItemsBloc, ItemsState>(
                            builder: (BuildContext context, ItemsState state) {
                              if (state is CheckBoxSelectedState) {
                                return Row(
                                  children: [
                                    categoryItemController.getCheckBoxState(
                                        item, context),
                                    Expanded(
                                        child: ItemThumbnail(
                                      item: item,
                                      checkBoxSelected: categoryItemController
                                          .isItemSelectable,
                                      controller: categoryItemController,
                                    )),
                                  ],
                                );
                              } else {
                                return Row(
                                  children: [
                                    categoryItemController.getCheckBoxState(
                                        item, context),
                                    Expanded(
                                        child: ItemThumbnail(
                                      item: item,
                                      checkBoxSelected: categoryItemController
                                          .isItemSelectable,
                                      controller: categoryItemController,
                                    )),
                                  ],
                                );
                              }
                            },
                          );
                        } else {
                          return ItemThumbnail(
                            item: item,
                            checkBoxSelected:
                                categoryItemController.isItemSelectable,
                            controller: categoryItemController,
                          );
                        }
                      }),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}