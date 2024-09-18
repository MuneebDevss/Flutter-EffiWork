import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Repository/items_repository.dart';

class ItemsReposImpl implements ItemsRepository {
  @override
  Future<Either<String, String>> addItem(Item item) async {
    try {
      Box<Item> box = await Hive.openBox<Item>('Item');
      await box.put(
          item.name, item); // Use await to ensure the operation is completed.
      return const Right("added");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editItemPropert(Item item) async {
    try {
      Box<Item> box = await Hive.openBox<Item>('Item');
      await box.put(item.name, item); 
      return const Right("updated");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> removeItems(List<Item> items) async {
    try {
      Box<Item> box = await Hive.openBox<Item>('Item');
      
      for (Item item in items) {
        
        await box.delete(item.name);
      }
      return const Right("removed");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Item>>> restrieveItem() async {
    try {
      Box<Item> box = await Hive.openBox<Item>('Item');
      List<Item> items = box.values.toList();
      return Right(items);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Item>>> restrieveByCategory(
      String category) async {
    try {
      Box<Item> box = await Hive.openBox<Item>('Item');
      List<Item> items = box.values.toList();
      List<Item> categorizedItems =
          items.where((item) => item.category == category).toList();
      return Right(categorizedItems);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
