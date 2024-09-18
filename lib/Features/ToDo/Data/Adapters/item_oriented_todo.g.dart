
part of 'package:where_is_my_stuff/Features/ToDo/Data/Models/item_oriented_todo.dart';

class ItemOrientedTodoAdapter implements TypeAdapter<ItemOrientedTodo> {
  @override
  final int typeId = 3;

  @override
  void write(BinaryWriter writer, ItemOrientedTodo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.items);
  }

  @override
  ItemOrientedTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemOrientedTodo(
        id: fields[0],
        status: fields[3],
        task: fields[1],
        time: fields[2],
        items: fields[4]);
  }
}
