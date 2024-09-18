import 'package:hive_flutter/adapters.dart';
import 'dart:convert'; // For encoding/decoding JSON
part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  String name;
  @HiveField(1)
  String price;
  @HiveField(2)
  String location;
  @HiveField(3)
  String image;
  @HiveField(4)
  final String category;
  @HiveField(5)
  Map<String, String> specifics;
  set setName(String name) {
    this.name = name;
  }

  set setLocation(String location) {
    this.location = location;
  }

  set setPrice(String price) {
    this.price = price;
  }

  Item(this.name, this.price, this.location, this.image, this.category,
      {this.specifics = const {}});
}
