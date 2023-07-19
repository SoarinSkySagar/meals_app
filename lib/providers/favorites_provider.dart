import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavNotifier extends StateNotifier<List<Meal>> {
  FavNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final mealIsfav = state.contains(meal);

    if (mealIsfav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favMealsProvider = StateNotifierProvider<FavNotifier, List<Meal>>(
  (ref) {
    return FavNotifier();
  },
);
