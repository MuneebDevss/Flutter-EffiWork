import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  final DateTime id;
  @HiveField(1)
  final String task;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final bool status;

  ToDo({required this.id, required this.task, required this.time, required this.status});
}
