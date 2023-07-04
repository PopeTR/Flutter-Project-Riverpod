import 'package:flutter/material.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final Function() onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // In order to allow the above styles to effect the below items, we need to add a clipBehavior
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: onSelectMeal,
        // Stack acts like absolute values. You can put items on top of each other (image behind text etc)
        child: Stack(
          // Stack children we start with the one on the back, and work our way forward
          children: [
            // Fade in animation thats smooth
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity),

            // Positioned is the absolute/relative example so you can add top, bottom, left properties
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

            // Text('Duration: ${meal.duration.toString()}'),
          ],
        ),
      ),
    );
  }
}
