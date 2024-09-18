part of 'to_do_blocs.dart';

class ToDosEvent {}

class AddEvent extends ToDosEvent {
  final ToDo toDo;

  AddEvent({required this.toDo});
}

class CheckBoxSelectedEvent extends ToDosEvent {}

class DragStartEvent extends ToDosEvent {}

class DeleteEvent extends ToDosEvent {
  final List<ToDo> toDo;

  DeleteEvent({required this.toDo});
}

class UpdateEvent extends ToDosEvent {
  final ToDo toDo;

  UpdateEvent({required this.toDo});
}

class RetrieveEvent extends ToDosEvent {
  final String type;

  RetrieveEvent({required this.type});
}

class RetrieveByCategoryEvent extends ToDosEvent {
  final String category;

  RetrieveByCategoryEvent({required this.category});
}
