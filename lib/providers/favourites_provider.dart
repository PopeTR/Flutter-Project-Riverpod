import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/models/meal.dart';

// Provider class is the wrong choice if you have dynamic data. In this case you use the StateProvider class
// IMPORTANT: In State Management, you must ALWAYS create a new object in memory. You cannot edit existing objects
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // what is the initial value ->

  // the constructor
  FavouriteMealsNotifier() : super([]);

  // all the methods that exist to change the value ->

  // Add or remove to favourites based on toggle
  bool toggleMealFavouriteStatus(Meal meal) {
    // state property holds your data

    // Here we are finding whether state contains your meal.
    final mealIsFavourite = state.contains(meal);

    // if meal is favourite, create a new list without the meal by filtering
    if (mealIsFavourite) {
      // Where operator creates a new list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // Otherwise we add the item to the state list
      // We must create a new list
      state = [...state, meal];
      return true;
    }
  }
}

final favouritesProvider =
// StateNotifierProvider is a generic type and it does understand that it returns a FavoriteMealsNotifier,
//but it does not understand, unfortunately, which data this FavoriteMealsNotifier will yield in the end. Therefore, here we should add angled brackets and add two generic type definitions here.
//The first one is FavoriteMealsNotifier, but the second one then is the data that will be yielded by the FavoriteMealsNotifier in the end.

    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
