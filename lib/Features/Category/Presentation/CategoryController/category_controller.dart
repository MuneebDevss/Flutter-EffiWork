class CategoryDescription {
  final String image, title;

  CategoryDescription({required this.image, required this.title});
}

class CategoryController {
  List<CategoryDescription> category = [
    CategoryDescription(
        image: 'assets/Icons/ShoesCategory.jpg', title: 'Shoes'),
    CategoryDescription(image: 'assets/Icons/Clothing.jpg', title: 'Clothing'),
    CategoryDescription(
        image: 'assets/Icons/Stationary.jpg', title: 'Stationary'),
    CategoryDescription(image: 'assets/Icons/Medicine.jpg', title: 'Medicine'),
    CategoryDescription(
        image: 'assets/Icons/KitchenWares.jpg', title: 'KitchenWares'),
    CategoryDescription(
        image: 'assets/Icons/Cosmetics.jpg', title: 'Cosmetics'),
    CategoryDescription(image: 'assets/Icons/Tech.jpg', title: 'Tech'),
    CategoryDescription(image: 'assets/Icons/random.jpg', title: 'Random'),
  ];
}
