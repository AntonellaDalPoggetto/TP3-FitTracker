import 'package:fittracker/presentation/entities/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';


StateProvider<List<Meal>> mealListProvider = StateProvider<List<Meal>>((ref) {
  return [
  Meal(name: "comida 1", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now()),
  Meal(name: "comida 2", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 1))),
  Meal(name: "comida 3", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 2))),
  Meal(name: "comida 4", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 3))),
  Meal(name: "comida 5", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 4))),
  Meal(name: "comida 6", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 5))),
  Meal(name: "comida 7", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 6))),
  Meal(name: "comida 8", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 7))),
  Meal(name: "comida 9", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 8))),
  Meal(name: "comida 10", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 9))),
  Meal(name: "comida 11", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 10))),
  Meal(name: "comida 12", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 11))),
  Meal(name: "comida 13", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 12))),
  Meal(name: "comida 14", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 13))),
  Meal(name: "comida 15", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 14))),
  Meal(name: "comida 16", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 15))),
  Meal(name: "comida 17", protein: Random().nextInt(5) + 1, calories: Random().nextInt(6) + 5, carbs: Random().nextInt(4) + 10, dateTime: DateTime.now().add(const Duration(days: 16)))
];

});
