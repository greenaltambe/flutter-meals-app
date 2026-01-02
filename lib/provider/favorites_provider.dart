import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meals.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:meals/models/meals.dart';

// class FavoriteMealNotifier extends StateNotifier<List<Meal>>{
//    FavoriteMealNotifier() : super([]);
//
//    bool toggleMealFavoriteStatus(Meal meal) {
//      final isFavorite = state.contains(meal);
//
//      if (isFavorite) {
//        state = state.where((mealElement) => mealElement.id != meal.id).toList();
//        return false;
//      } else {
//        state = [...state, meal];
//       return true;
//      }
//    }
// }
//
// final favoriteMealProvider = StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
//   return FavoriteMealNotifier();
// });

class FavoriteMealsNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    return [];
  }

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
NotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  FavoriteMealsNotifier.new
);