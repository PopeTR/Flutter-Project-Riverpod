import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/data/dummy_data.dart';

// This is good for static data
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
