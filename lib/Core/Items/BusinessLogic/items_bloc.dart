import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Repository/items_repository.dart';

part 'item_state.dart';
part 'items_event.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository rep;
  ItemsBloc({required this.rep}) : super(InitialState()) {
    on<AddEvent>(_handleAddItemEvent);
    on<DeleteEvent>(_handleDeleteItemEvent);
    on<UpdateEvent>(_handleUpdateItemEvent);
    on<RetrieveEvent>(_handleRetrieveItemEvent);
    on<RetrieveByCategoryEvent>(_handleRetrieveByCategoryItemEvent);
    on<CheckBoxSelectedEvent>(_handleCheckBoxSelectedEvent);
    on<DragStartEvent>(_handleDragEvent);
  }

  Future<FutureOr<void>> _handleAddItemEvent(
      AddEvent event, Emitter<ItemsState> emit) async {
    emit(LoadingState());
    final res = await rep.addItem(event.item);
    res.fold((valu) => emit(FailedState(valu)), (valu) => emit(AddedState()));
  }

  Future<FutureOr<void>> _handleDeleteItemEvent(
      DeleteEvent event, Emitter<ItemsState> emit) async {
    emit(LoadingState());
    final res = await rep.removeItems(event.item);
    res.fold((valu) => emit(FailedState(valu)),
        (valu) => emit(RemovedState(message: valu)));
  }

  Future<FutureOr<void>> _handleUpdateItemEvent(
      UpdateEvent event, Emitter<ItemsState> emit) async {
    emit(LoadingState());
    final res = await rep.editItemPropert(event.item);
    res.fold((valu) => emit(FailedState(valu)), (valu) => emit(UpdatedState(message: valu)));
  }

  Future<FutureOr<void>> _handleRetrieveItemEvent(
      RetrieveEvent event, Emitter<ItemsState> emit) async {
    emit(LoadingState());
    final res = await rep.restrieveItem();
    res.fold((valu) => emit(FailedState(valu)),
        (valu) => emit(RetrievedState(items: valu)));
  }

  Future<FutureOr<void>> _handleRetrieveByCategoryItemEvent(
      RetrieveByCategoryEvent event, Emitter<ItemsState> emit) async {
    emit(LoadingState());
    final res = await rep.restrieveByCategory(event.category);
    res.fold((valu) => emit(FailedState(valu)),
        (valu) => emit(RetrievedState(items: valu)));
  }

  FutureOr<void> _handleCheckBoxSelectedEvent(
      CheckBoxSelectedEvent event, Emitter<ItemsState> emit) {
    emit(CheckBoxSelectedState());
  }

  FutureOr<void> _handleDragEvent(
      DragStartEvent event, Emitter<ItemsState> emit) {
    emit(DragState());
  }
}
