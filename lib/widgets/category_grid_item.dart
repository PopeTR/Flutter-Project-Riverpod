import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });
  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // InkWell can make any widget tappable. GestureDector could also be used for this too but InkWell you get feedback to show you have clicked
    return InkWell(
      onTap: onSelectCategory,
      // splashColor gives a nice highlighted color if you tap and hold
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      // Container widget gives the option for background and Padding!!!
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  category.color.withOpacity(0.55),
                  category.color.withOpacity(0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )),
    );
  }
}
