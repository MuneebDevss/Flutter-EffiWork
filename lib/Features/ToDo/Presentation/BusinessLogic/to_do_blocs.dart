import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Repository/to_do_repository.dart';

part 'to_do_bloc_state.dart';
part 'to_do_bloc_event.dart';
class ToDoBloc extends Bloc<ToDosEvent, ToDosState> {
  final ToDoRepository rep;
  ToDoBloc({required this.rep}) : super(InitialState()) {
    on<AddEvent>(_handleAddItemEvent);
    on<DeleteEvent>(_handleDeleteItemEvent);
    on<UpdateEvent>(_handleUpdateItemEvent);
    on<RetrieveEvent>(_handleRetrieveItemEvent);
    
    on<CheckBoxSelectedEvent>(_handleCheckBoxSelectedEvent);
    on<DragStartEvent>(_handleDragEvent);
  }

  Future<FutureOr<void>> _handleAddItemEvent(
      AddEvent event, Emitter<ToDosState> emit) async {
    emit(LoadingState());
    final res = await rep.addItem(event.toDo);
    res.fold((valu) => emit(FailedState(valu)), (valu) => emit(AddedState()));
  }

  Future<FutureOr<void>> _handleDeleteItemEvent(
      DeleteEvent event, Emitter<ToDosState> emit) async {
    emit(LoadingState());
    final res = await rep.removeItems(event.toDo);
    res.fold((valu) => emit(FailedState(valu)),
        (valu) => emit(RemovedState(message: valu)));
  }

  Future<FutureOr<void>> _handleUpdateItemEvent(
      UpdateEvent event, Emitter<ToDosState> emit) async {
    emit(LoadingState());
    final res = await rep.editItemPropert(event.toDo);
    res.fold((valu) => emit(FailedState(valu)), (valu) => emit(UpdatedState(message: valu)));
  }

  Future<FutureOr<void>> _handleRetrieveItemEvent(
      RetrieveEvent event, Emitter<ToDosState> emit) async {
    emit(LoadingState());
    final res = await rep.restrieveItem(event.type);
    res.fold((valu) => emit(FailedState(valu)),
        (valu) => emit(RetrievedState(toDos: valu)));
  }

  FutureOr<void> _handleCheckBoxSelectedEvent(
      CheckBoxSelectedEvent event, Emitter<ToDosState> emit) {
    emit(CheckBoxSelectedState());
  }

  FutureOr<void> _handleDragEvent(
      DragStartEvent event, Emitter<ToDosState> emit) {
    emit(DragState());
  }
}
