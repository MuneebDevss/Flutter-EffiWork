import 'package:fpdart/fpdart.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';


abstract class ItemsRepository {
  Future<Either<String, String>> addItem(Item item);
  Future<Either<String, String>> removeItems(List<Item> item);
  Future<Either<String, String>> editItemPropert(Item item);
  Future<Either<String, List<Item>>> restrieveItem();
  Future<Either<String, List<Item>>> restrieveByCategory(String category);
}
