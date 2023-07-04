import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/screens/categories.dart';
import 'package:meals_riverpod/screens/filters.dart';
import 'package:meals_riverpod/screens/meals.dart';
import 'package:meals_riverpod/widgets/main_drawer.dart';
import '../providers/favourites_provider.dart';
import '../providers/filters_provider.dart';
import '../providers/meals_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// ConsumerStatefulWidget for StatefulWidget used ConsumerWidget for stateless.
// This allows us to interact with the Provider
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  // Add ConsumerState type here
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// You also need to add ConsumerState here
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

// We are removing the async await as we are no longer getting a result back from FiltersScreen. We are now managing in the Provider.
  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref is setup by Riverpod which allows us to listen to state changes.
    // ref.read gets data once
    // ref.watch sets up a listener that makes sure the build method executes again as our data changes
    // Documentation said use watch over read always.
    final meals = ref.watch(mealsProvider);

    // Getting filters from provider
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      // Replaced old _selectedFilters returned from Future _setScreen with activeFilters from Provider
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouritesProvider);
      activePage = MealsScreen(meals: favouriteMeals);
      activePageTitle = 'Your favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
