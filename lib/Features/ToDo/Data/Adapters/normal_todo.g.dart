part of 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';



class NormalTodoAdapter implements TypeAdapter<NormalTodo> {
  @override
  final int typeId = 2;

  @override
  void write(BinaryWriter writer, NormalTodo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  NormalTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NormalTodo(
      id: fields[0],
      status: fields[3],
      task: fields[1],
      time: fields[2],
    );
  }
}
