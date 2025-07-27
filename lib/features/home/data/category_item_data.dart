import 'package:resturant_app/generated/assets.dart';

class CategoryItemData {
  final String title;
  final String imageCategory;
  CategoryItemData({required this.title, required this.imageCategory});
}



List<CategoryItemData> categoryItems = [
  CategoryItemData(title: 'Pizza', imageCategory: Assets.categoryIconPizza),
  CategoryItemData(title: 'Burger', imageCategory: Assets.categoryIconBurger),
  CategoryItemData(title: 'Sushi', imageCategory: Assets.categoryIconSushi),
  CategoryItemData(title: 'Salad', imageCategory: Assets.categoryIconSalad),
  CategoryItemData(title: 'Dessert', imageCategory: Assets.categoryIconDesert),
  CategoryItemData(title: 'Drinks', imageCategory: Assets.categoryIconDrinks),
  CategoryItemData(title: 'Pasta', imageCategory: Assets.categoryIconPasta),
  CategoryItemData(title: 'sandwich', imageCategory: Assets.categoryIconSandawith),
];

