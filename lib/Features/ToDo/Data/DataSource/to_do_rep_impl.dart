import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/item_oriented_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Data/Models/normal_todo.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Repository/to_do_repository.dart';

class ToDOReposImpl implements ToDoRepository {
  @override
  Future<Either<String, String>> addItem(ToDo item) async {
    try {
      if (item is NormalTodo) {
        Box<NormalTodo> box = await Hive.openBox<NormalTodo>('NormalToDO');
        await box.put((item).id, item);
      } else {
        Box<ItemOrientedTodo> box =
            await Hive.openBox<ItemOrientedTodo>('ItemOrientedToDO');
        await box.put((item).id, item as ItemOrientedTodo);
      }
      return const Right("added");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editItemPropert(ToDo item) async {
    try {
      if (item is NormalTodo) {
        Box<NormalTodo> box = await Hive.openBox<NormalTodo>('NormalToDO');
        await box.put((item).id, item);
      } else {
        Box<ItemOrientedTodo> box =
            await Hive.openBox<ItemOrientedTodo>('ItemOrientedToDO');
        await box.put((item).id, item as ItemOrientedTodo);
      }
      return const Right("updated");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> removeItems(List<ToDo> items) async {
    try {
      for (ToDo item in items) {
        if (item is NormalTodo) {
          Box<NormalTodo> box = await Hive.openBox<NormalTodo>('NormalToDO');
          await box.delete((item).id);
        } else {
          Box<ItemOrientedTodo> box =
              await Hive.openBox<ItemOrientedTodo>('ItemOrientedToDO');
          await box.delete((item).id);
        }
      }

      return const Right("removed");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ToDo>>> restrieveItem(String type) async {
    try {
      Box<ToDo> box;
      if (type == 'NormalTodo') {
        box = await Hive.openBox<NormalTodo>('NormalToDO');
      } else {
         box =
            await Hive.openBox<ItemOrientedTodo>('ItemOrientedToDO');
      }
      List<ToDo> items = box.values.toList();
      return Right(items);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
