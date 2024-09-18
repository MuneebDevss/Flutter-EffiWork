part of 'items_bloc.dart';

class ItemsEvent {}

class AddEvent extends ItemsEvent {
  final Item item;

  AddEvent({required this.item});
}

class CheckBoxSelectedEvent extends ItemsEvent {}

class DragStartEvent extends ItemsEvent {}

class DeleteEvent extends ItemsEvent {
  final List<Item> item;

  DeleteEvent({required this.item});
}

class UpdateEvent extends ItemsEvent {
  final Item item;

  UpdateEvent({required this.item});
}

class RetrieveEvent extends ItemsEvent {}

class RetrieveByCategoryEvent extends ItemsEvent {
  final String category;

  RetrieveByCategoryEvent({required this.category});
}
