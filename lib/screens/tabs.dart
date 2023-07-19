import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';


const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _Tabs();
  }
}

class _Tabs extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favMeals = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  final titles = const [
    'Categories',
    'Your Favorites',
  ];

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String str) async {
    Navigator.of(context).pop();
    if (str == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilter,
          ),
        ),
      );
      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(provider)   for reading data once
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where(
      (meal) {
        if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    // final favMeals = ref.watch(favMealsProvider);

    final screen = [
      CategoryScreen(
        availableMeals: availableMeals,
      ),
      MealScreen(
        meals: ref.watch(favMealsProvider),
      ),
    ];

    Widget activePage = screen[_selectedPageIndex];
    var titlePage = titles[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
