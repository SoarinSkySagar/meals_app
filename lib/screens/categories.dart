import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/grid.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.availableMeals,
  });


  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filtered = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealScreen(
                meals: filtered,
                title: category.title,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: availableCategories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = availableCategories[index];
        return GridItem(
          category: category,
          onSelect: () {
            _selectCategory(context, category);
          },
        );
      },
    );
  }
}
