import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/HelpingFunctions/image_picker.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';

class QuickAddController {
  FocusNode name = FocusNode();
  FocusNode location = FocusNode();
  FocusNode price = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String selectedCategory = 'Other', image = '';
  List<DropdownMenuItem<String>> dropdownItems = const [
    DropdownMenuItem<String>(
      value: 'Shoes',
      child: Text('Shoes'),
    ),
    DropdownMenuItem<String>(
      value: 'Clothing',
      child: Text('Clothing'),
    ),
    DropdownMenuItem<String>(
      value: 'Stationary',
      child: Text('Stationary'),
    ),
    DropdownMenuItem<String>(
      value: 'Medicine',
      child: Text('Medicine'),
    ),
    DropdownMenuItem<String>(
      value: 'KitchenWares',
      child: Text('KitchenWares'),
    ),
    DropdownMenuItem<String>(
      value: 'Cosmetics',
      child: Text('Cosmetics'),
    ),
    DropdownMenuItem<String>(
      value: 'Tech',
      child: Text('Tech'),
    ),
    DropdownMenuItem<String>(
      value: 'Other',
      child: Text('Other'),
    ),
  ];

  nameSubmitted() {
    location.requestFocus();
  }

  locationSubmitted() {
    price.requestFocus();
  }

  priceSubmitted() {}

  Future<void> cancel(BuildContext context) async {
    if (nameController.text.trim().isNotEmpty ||
        locationController.text.trim().isNotEmpty ||
        priceController.text.trim().isNotEmpty) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are You sure you want Leave'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Confirm')),
              ],
            );
          });
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void add(BuildContext context) {
    if (nameController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return const AlertDialog(
              title: Text('you need to fill the name at the very least'),
            );
          });
    } else {
      Item item = Item(nameController.text.trim(), priceController.text.trim(),
          locationController.text.trim(), image, selectedCategory);
      context.read<ItemsBloc>().add(AddEvent(item: item));
    }
  }

  Future<void> addImage() async {
    image = await pickImage();
  }
}
