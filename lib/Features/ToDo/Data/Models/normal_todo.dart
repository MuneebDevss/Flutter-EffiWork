import 'package:hive_flutter/adapters.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';

part '../Adapters/normal_todo.g.dart';



@HiveType(typeId: 2)
class NormalTodo extends ToDo {
  NormalTodo(
      {required super.status,
      required super.task,
      required super.time,
      required super.id});
}
