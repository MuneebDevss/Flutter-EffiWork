part of 'to_do_blocs.dart';



class ToDosState {}

class CheckBoxSelectedState extends ToDosState {}

class InitialState extends ToDosState {}

class AddedState extends ToDosState {}

class DragState extends ToDosState {}

class RemovedState extends ToDosState {
  final String message;

  RemovedState({required this.message});
}

class RetrievedState extends ToDosState {
  final List<ToDo> toDos;

  RetrievedState({required this.toDos});
}

class LoadingState extends ToDosState {}

class UpdatedState extends ToDosState {
  final String message;

  UpdatedState({required this.message});
}

class FailedState extends ToDosState {
  final String message;

  FailedState(this.message);
}

