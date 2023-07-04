import 'package:flutter/material.dart';
import 'package:meals_riverpod/models/meal.dart';

import '../widgets/meal_item.dart';
import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  // Title is conditionally passed here
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  // ? added to show that title is conditionally passed
  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    // pushing this route ontop of the current stack of screens
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: () {
            _selectMeal(context, meals[index]);
          }),
      itemCount: meals.length,
    );

    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Uh oh...'),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ));
    }

    /**  The below condition is set because we have two titles – a title from tabsscreen 
     * and a title below in the Scaffold. 
     * 
     * We need the Scaffold here because we need the appbar for category but we dont need it for favourites, 
     * so instead we conditionally render title based on if it is passed or not. 
     * 
     * Then, if no title, no extra title is set. But if title is set, we show it */
    if (title == null) {
      return content;
    }

    // As we are a screen, we need the scaffold widget!
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
