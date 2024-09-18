import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';

class ItemDescriptionController {
  ValueNotifier<bool> editIconPressed = ValueNotifier<bool>(false);
  late AnimationController bottomSheetController;
  late Animation<double> bottomSheetAnimation;
  final String name = 'name', location = 'location', price = 'price';
  String updatingValue = '';
  late Item updateAbleItem;
  Map<String, String> specifics = {};
  TextEditingController textController = TextEditingController();
  void editProperty(Item item, String value) {
    if (name == value) {
      updatingValue = name;
    } else if (location == value) {
      updatingValue = location;
    } else if (price == value) {
      updatingValue = price;
    } else {
      // Check if the value exists in any of the specifics maps
      item.specifics.containsValue(value)
          ? updatingValue = value
          : updatingValue = 'none';
    }
    editIconPressed.value = true;
    updateAbleItem = item;
    bottomSheetController.forward();
  }

  void submitChange(BuildContext context) {
    if (textController.text.trim().isEmpty) {
      bottomSheetController.reverse();
      return;
    }
    if (updatingValue == name) {
      updateAbleItem.name = textController.text.trim();
    } else if (updatingValue == location) {
      updateAbleItem.location = textController.text.trim();
    } else if (updatingValue == price) {
      updateAbleItem.price = textController.text.trim();
    } else if (updatingValue != 'none') {
      specifics[updatingValue] = textController.text.trim();
    }

    context.read<ItemsBloc>().add(UpdateEvent(item: updateAbleItem));
    editIconPressed.value = false;
    bottomSheetController.reverse();
  }
}
