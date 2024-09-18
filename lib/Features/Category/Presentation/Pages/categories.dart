import 'package:flutter/material.dart';
import 'package:where_is_my_stuff/Core/Constants/Size/sizes.dart';
import 'package:where_is_my_stuff/Core/widgets/space_between.dart';
import 'package:where_is_my_stuff/Features/Category/Presentation/CategoryController/category_controller.dart';
import 'package:where_is_my_stuff/Features/Category/Presentation/Pages/category_items.dart';

class Categories extends StatefulWidget {
  Categories({super.key});
  final CategoryController categoryController = CategoryController();
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        
      ),
      body: SingleChildScrollView( 
        child: Column(
          children:
              List.generate(widget.categoryController.category.length, (index) {
            CategoryDescription category =
                widget.categoryController.category[index];
            return Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'SecularOne'),
                  ),
                  const SpaceBetweenItems(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryItems(category: category.title)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        category.image,
                        width: screenWidth / 1.1,
                        height: screenHeight / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
