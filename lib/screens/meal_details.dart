import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:meals_riverpod/providers/favourites_provider.dart';

// Changed to ConsumerWidget
class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  // If you have a stateless class, you need to pass a second parameter ref.
  // We dont have a general ref property in stateless
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // we read only in a function like onPressed
                // notifier gives us access to the notifier class we set up
                // when read has returned the results we can then use the toggle method in the class
                final wasAdded = ref
                    .read(favouritesProvider.notifier)
                    .toggleMealFavouriteStatus(meal);
                // This came from our Snackbar method in tabs which we can now put more accurately on the Meal Details page.
                // The message we display can be determined by the return of the toggleMealFavourite, so we can adjust the return to be a boolean
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Meal Added as favourite'
                        : 'Meal removed')));
              },
              icon: const Icon(Icons.star))
        ],
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            ...meal.ingredients.map(
              (e) => Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            ...meal.steps.map(
              (e) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
