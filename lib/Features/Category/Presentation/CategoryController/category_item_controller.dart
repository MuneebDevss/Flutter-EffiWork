import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/controller/Items_view_interface.dart';

class CategoryItemController implements ItemsViewInterface {
  @override
  bool isItemSelectable = false;

  @override
  void checkActionTapped() {
    if (isItemSelectable) {
      //remove all the selected items when the check box is unselected
      selectedItems.clear();
    }
    isItemSelectable = !isItemSelectable;
  }

  @override
  FocusNode searchNode = FocusNode();
  @override
  List<Item> items = [];
  @override
  List<Item> selectedItems = [];
  @override
  getCheckBoxState(Item item, BuildContext context) {
    if (selectedItems.contains(item)) {
      return IconButton(
          onPressed: () {
            selectedItems.remove(item);
            context.read<ItemsBloc>().add(CheckBoxSelectedEvent());
          },
          icon: const Icon(Icons.check_box));
    } else {
      return IconButton(
          onPressed: () {
            selectedItems.add(item);
            context.read<ItemsBloc>().add(CheckBoxSelectedEvent());
          },
          icon: const Icon(Icons.check_box_outline_blank));
    }
  }

  @override
  void deleteActionTapped(BuildContext context) {
    context.read<ItemsBloc>().add(DeleteEvent(item: selectedItems));
    isItemSelectable = false;
  }

  @override
  getPadding() {
    if (isItemSelectable) {
      return const EdgeInsets.only(
          left: 0, right: Sizes.appBarHeight, top: Sizes.spaceBtwItems);
    } else {
      return const EdgeInsets.only(
          left: Sizes.spaceBtwItems,
          right: Sizes.appBarHeight,
          top: Sizes.spaceBtwItems);
    }
  }

  @override
  void deleteTheDraggedItem(BuildContext context, Item item) {
    selectedItems = [item];
    context.read<ItemsBloc>().add(DeleteEvent(item: selectedItems));
    itemDragged.value = false;
  }

  @override
  void dragStarted(BuildContext context) {
    itemDragged.value = true;
  }

  @override
  ValueNotifier<bool> itemDragged = ValueNotifier<bool>(false);
}
