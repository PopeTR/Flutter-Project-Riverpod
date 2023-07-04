import 'package:flutter/material.dart';
import 'package:meals_riverpod/data/dummy_data.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:meals_riverpod/screens/meals.dart';
import 'package:meals_riverpod/widgets/category_grid_item.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  // final List<Category> availableCategories;
  final List<Meal> availableMeals;
// Used to navigate between screens!
  void _selectCategory(BuildContext context, Category category) {
    // pushing this route ontop of the current stack of screens
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: [
            ...availableMeals
                .where((element) => element.categories.contains(category.id))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Common to setup scaffold inside screen as they change a lot. Scaffold was here but we removed as we already have the page title from tabs screen.
    return
        // If you use GridView.builder it allows you to render only whats on the screen (like ListView.builder)
        // Here we only have a few so not needed
        GridView(
            padding: const EdgeInsets.all(24),
            // gridDelegate tells us the layout
            gridDelegate:
                // This gives us the columns and the spacing
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
          ...availableCategories.map((e) => CategoryGridItem(
                category: e,
                onSelectCategory: () {
                  _selectCategory(context, e);
                },
              ))
        ]);
    // );
  }
}
