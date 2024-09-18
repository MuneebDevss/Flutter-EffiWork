import 'dart:io';

import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/controller/Items_view_interface.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/ItemDescription/Presentaion/Pages/item_description.dart';

class ItemThumbnail extends StatefulWidget {
  const ItemThumbnail({
    super.key,
    required this.item,
    required this.checkBoxSelected,
    required this.controller,
  });

  final Item item;
  final bool checkBoxSelected;
  final ItemsViewInterface controller;
  @override
  State<ItemThumbnail> createState() => _ItemThumbnailState();
}

class _ItemThumbnailState extends State<ItemThumbnail> {
  double width = 341;
  @override
  void initState() {
    width = widget.checkBoxSelected ? width - 50 : width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      onDragStarted: () {
        widget.controller.dragStarted(context);
      },
      feedback: const Icon(Icons.insert_emoticon),
      data: widget.item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDescription(item: widget.item))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8C9E),
            borderRadius: BorderRadius.circular(Sizes.sm + 2),
          ),
          width: width,
          // height: 301,
          child: Column(
            children: [
              if (widget.item.image.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(widget.item.image),
                    width: width,
                    height: 143,
                    fit: BoxFit.cover,
                  ),
                ),
              if (widget.item.name.isNotEmpty)
                ItemDescriptionRow(
                  item: widget.item,
                  image: 'assets/Icons/Label.png',
                  text: widget.item.name,
                ),
              if (widget.item.location.isNotEmpty)
                ItemDescriptionRow(
                  item: widget.item,
                  image: 'assets/Icons/Location.png',
                  text: widget.item.location,
                ),
              if (widget.item.price.isNotEmpty)
                ItemDescriptionRow(
                  item: widget.item,
                  image: 'assets/Icons/CashIcon.png',
                  text: widget.item.price,
                ),
              const SpaceBetweenItems(),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDescriptionRow extends StatelessWidget {
  const ItemDescriptionRow({
    super.key,
    required this.item,
    required this.image,
    required this.text,
  });

  final Item item;
  final String image, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: Sizes.spaceBtwItems),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 24,
            height: 24,
            colorBlendMode: BlendMode.darken,
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 240,
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'SecularOne'),
            ),
          )
        ],
      ),
    );
  }
}
