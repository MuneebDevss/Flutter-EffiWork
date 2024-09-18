import 'package:fpdart/fpdart.dart';
import 'package:where_is_my_stuff/Features/ToDo/Domain/Entities/to_do.dart';


abstract class ToDoRepository {
  Future<Either<String, String>> addItem(ToDo item);
  Future<Either<String, String>> removeItems(List<ToDo> item);
  Future<Either<String, String>> editItemPropert(ToDo item);
  Future<Either<String, List<ToDo>>> restrieveItem(String type);
  
}
