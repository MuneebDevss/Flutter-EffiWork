import 'package:hive_flutter/adapters.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';
part 'package:where_is_my_stuff/Features/ToDo/Data/Adapters/item_oriented_todo.g.dart';

@HiveType(typeId: 3)
class ItemOrientedTodo extends ToDo {
  @HiveField(4)
  final Item items;
  
  ItemOrientedTodo(
      {required super.status,
      required this.items,
      required super.task,
      required super.time, required super.id});
}
