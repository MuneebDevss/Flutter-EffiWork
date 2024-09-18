import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';

abstract class ItemsViewInterface {
  List<Item> items = [];
  List<Item> selectedItems = [];
  bool isItemSelectable = false;
  FocusNode searchNode = FocusNode();
  ValueNotifier<bool> itemDragged = ValueNotifier<bool>(false);
  void deleteTheDraggedItem(BuildContext context, Item item) {}
  void checkActionTapped();
  getCheckBoxState(Item item, BuildContext context);
  void deleteActionTapped(BuildContext context);
  getPadding();

  void dragStarted(BuildContext context);
}
