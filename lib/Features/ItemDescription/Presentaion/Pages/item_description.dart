import 'dart:io';
import 'package:where_is_my_stuff/Core/widgets/bottom_sheet.dart'
    as bottomsheet;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Features/ItemDescription/Presentaion/ItemDescriptionController/item_description_controller.dart';

class ItemDescription extends StatefulWidget {
  const ItemDescription({super.key, required this.item});
  final Item item;
  @override
  State<StatefulWidget> createState() {
    return _ItemDescriptionState();
  }
}

class _ItemDescriptionState extends State<ItemDescription>
    with SingleTickerProviderStateMixin {
  late double screenWidth, screenHeight;
  final ItemDescriptionController descriptionController =
      ItemDescriptionController();

  @override
  void dispose() {
    descriptionController.textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initiliazeAnimations();
    super.initState();
  }

  void initiliazeAnimations() {
    descriptionController.bottomSheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    descriptionController.bottomSheetAnimation =
        Tween<double>(begin: -Sizes.appBarHeight * 5, end: 0)
            .animate(descriptionController.bottomSheetController);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Item Description'),
      ),
      body: Stack(
        children: [
          BlocConsumer<ItemsBloc, ItemsState>(
            builder: (BuildContext context, ItemsState state) {
              if (state is LoadingState) {
                return const CircularProgressIndicator();
              }
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.requestFocus();
                  descriptionController.bottomSheetController.reverse();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.item.image.isNotEmpty)
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Image.file(
                            File(widget.item.image),
                            width: screenWidth,
                            height: 246,
                            fit: BoxFit.cover,
                          )),
                    const SpaceBetweenSections(),
                    const Padding(
                      padding: EdgeInsets.only(left: Sizes.md),
                      child: Text(
                        'General',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'SecularOne'),
                      ),
                    ),
                    GeneralDescriptionRow(
                        parameterName: 'Name',
                        parameterValue: widget.item.name,
                        onEdit: () {
                          descriptionController.editProperty(
                              widget.item, 'name');
                          setState(() {});
                        },
                        screenWidth: screenWidth),
                    const SpaceBetweenItems(),
                    if (widget.item.location.isNotEmpty)
                      GeneralDescriptionRow(
                        parameterName: 'Location',
                        parameterValue: widget.item.location,
                        screenWidth: screenWidth,
                        onEdit: () {
                          descriptionController.editProperty(
                              widget.item, 'location');

                          setState(() {});
                        },
                      ),
                    const SpaceBetweenItems(),
                    if (widget.item.price.isNotEmpty)
                      GeneralDescriptionRow(
                        parameterName: 'Price',
                        parameterValue: widget.item.price,
                        onEdit: () {
                          descriptionController.editProperty(
                              widget.item, 'price');
                          setState(() {});
                        },
                        screenWidth: screenWidth,
                      ),
                    const Divider(),
                    const SpaceBetweenItems(),
                    const Padding(
                      padding: EdgeInsets.only(left: Sizes.md),
                      child: Text(
                        'Specifics',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'SecularOne'),
                      ),
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, ItemsState state) {
              if (state is FailedState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is UpdatedState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          Positioned(
              top: 5,
              child: Container(
                color: Colors.black,
                width: screenWidth,
                height: 5,
              )),
          bottomsheet.BottomSheet(
              screenWidth: screenWidth,
              animation: descriptionController.bottomSheetAnimation,
              animationController: descriptionController.bottomSheetController,
              onSubmit: () {
                descriptionController.submitChange(context);
                setState(() {});
              },
              headingText: 'Update ${descriptionController.updatingValue}',
              textController: descriptionController.textController)
        ],
      ),
    );
  }
}

class GeneralDescriptionRow extends StatelessWidget {
  const GeneralDescriptionRow({
    super.key,
    required this.parameterName,
    required this.parameterValue,
    required this.onEdit,
    required this.screenWidth,
  });

  final String parameterName, parameterValue;
  final double screenWidth;
  final VoidCallback onEdit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.xl),
      child: SizedBox(
        width: screenWidth - (Sizes.xl * 2),
        child: Row(
          children: [
            Text(
              parameterName,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'SecularOne',
                  color: Colors.black.withOpacity(0.5)),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                parameterValue,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'SecularOne'),
              ),
            ),
            IconButton(
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit,
                  size: 24,
                )),
          ],
        ),
      ),
    );
  }
}
