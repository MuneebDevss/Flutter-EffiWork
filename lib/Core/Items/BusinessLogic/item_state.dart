part of 'items_bloc.dart';

class ItemsState {}

class CheckBoxSelectedState extends ItemsState {}

class InitialState extends ItemsState {}

class AddedState extends ItemsState {}

class DragState extends ItemsState {}

class RemovedState extends ItemsState {
  final String message;

  RemovedState({required this.message});
}

class RetrievedState extends ItemsState {
  final List<Item> items;

  RetrievedState({required this.items});
}

class LoadingState extends ItemsState {}

class UpdatedState extends ItemsState {
  final String message;

  UpdatedState({required this.message});
}

class FailedState extends ItemsState {
  final String message;

  FailedState(this.message);
}
