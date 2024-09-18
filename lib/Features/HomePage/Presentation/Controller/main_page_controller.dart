import 'package:flutter/material.dart';

class MainPageController {
  late int totalItems;
  late int toDos;
  late FocusNode searchNode;
  MainPageController() {
    totalItems = 0;
    toDos = 0;
    searchNode = FocusNode();
  }
}
