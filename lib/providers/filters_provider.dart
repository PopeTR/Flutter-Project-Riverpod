import 'package:flutter_riverpod/flutter_riverpod.dart';

// Moving enum Filter here as this is where the all the meta management of filters and all the type definitions for filters basically happen.
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // super takes the initial state. So for filters provider, we need to have the state as all false
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // Here we are creating a NEW Map, by copying all values across and updating the one in question to the required value.
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});
