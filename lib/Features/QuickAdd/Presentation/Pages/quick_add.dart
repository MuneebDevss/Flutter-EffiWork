import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/QuickAdd/Presentation/Controllers/quick_add_controller.dart';

class QuickAdd extends StatefulWidget {
  const QuickAdd({super.key});

  @override
  State<QuickAdd> createState() => _QuickAddState();
}

class _QuickAddState extends State<QuickAdd> {
  final QuickAddController quickAddController = QuickAddController();
  @override
  void dispose() {
    quickAddController.price.dispose();
    quickAddController.name.dispose();
    quickAddController.location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Add'),
      ),
      body: BlocListener<ItemsBloc, ItemsState>(
        listener: (BuildContext context, ItemsState state) {
          if (state is FailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              duration: const Duration(minutes: 1),
            ));
          }
          if (state is AddedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Added')));
            Future.delayed(
                const Duration(seconds: 2), () => Navigator.pop(context));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpace),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Add new Items',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/Icons/CupBoards.png',
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const SpaceBetweenItems(),
                      if (quickAddController.image.trim().isEmpty)
                        GestureDetector(
                          onTap: () => quickAddController.addImage(),
                          child: Container(
                            width: double.maxFinite,
                            height: 163,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(Sizes.sm),
                            ),
                            child: const Center(child: Icon(Icons.add_a_photo)),
                          ),
                        ),
                      const SpaceBetweenItems(),
                      if (quickAddController.image.trim().isNotEmpty)
                        GestureDetector(
                          onTap: () => quickAddController.addImage(),
                          child: Container(
                            width: double.maxFinite,
                            height: 163,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(Sizes.sm),
                            ),
                            child: Center(
                                child: Image.file(
                              File(quickAddController.image),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      const SpaceBetweenItems(),
                      QuickAddTextFormField(
                        controller: quickAddController.nameController,
                        image: 'assets/Icons/Label.png',
                        hintText: 'Name',
                        onSubmitted: quickAddController.nameSubmitted,
                        node: quickAddController.name,
                      ),
                      const SpaceBetweenItems(),
                      QuickAddTextFormField(
                        controller: quickAddController.locationController,
                        image: 'assets/Icons/Location.png',
                        hintText: 'Location',
                        onSubmitted: quickAddController.locationSubmitted,
                        node: quickAddController.location,
                      ),
                      const SpaceBetweenItems(),
                      QuickAddTextFormField(
                        controller: quickAddController.priceController,
                        image: 'assets/Icons/CashIcon.png',
                        hintText: 'Price',
                        onSubmitted: quickAddController.priceSubmitted,
                        node: quickAddController.price,
                      ),
                      const SpaceBetweenItems(),
                      Row(
                        children: [
                          const Text(
                            'Select Category:',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.blue.shade200,
                              ),
                              child: DropdownButton(
                                items: quickAddController.dropdownItems,
                                onChanged: (value) {
                                  if (value != null) {
                                    quickAddController.selectedCategory = value;
                                    setState(() {});
                                  }
                                },
                                value: quickAddController.selectedCategory,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SpaceBetweenSections(),
                      Row(
                        children: [
                          TextColoredButton(
                            text: 'Cancel',
                            color: 0xFFD9D9D9,
                            onTap: () => quickAddController.cancel(context),
                          ),
                          const Spacer(),
                          TextColoredButton(
                            text: 'Add',
                            color: 0xFFFF8A8A,
                            onTap: () {
                              quickAddController.add(context);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextColoredButton extends StatelessWidget {
  const TextColoredButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });
  final String text;
  final int color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 47,
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(Sizes.sm)),
        child: Center(child: Text(text)),
      ),
    );
  }
}

class QuickAddTextFormField extends StatelessWidget {
  const QuickAddTextFormField(
      {super.key,
      required this.image,
      required this.hintText,
      required this.onSubmitted,
      required this.node,
      required this.controller});
  final FocusNode node;
  final String image, hintText;
  final VoidCallback onSubmitted;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.maxFinite,
      child: TextFormField(
          controller: controller,
          focusNode: node,
          onFieldSubmitted: (value) {
            onSubmitted();
          },
          decoration: InputDecoration(
              prefixIcon: Image.asset(image),
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)))),
    );
  }
}
