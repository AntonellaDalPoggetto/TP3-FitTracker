import 'package:fittracker/presentation/entities/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


StateProvider<List<Meal>> mealListProvider = StateProvider<List<Meal>>((ref) {
  return [
  Meal(name: "comida 1", protein: 5, calories: 12, carbs: 14, dateTime: DateTime.now()),
  Meal(name: "comida 2", protein: 7, calories: 20, carbs: 16, dateTime: DateTime.now().add(const Duration(days: 1))),
  Meal(name: "comida 3", protein: 3, calories: 18, carbs: 12, dateTime: DateTime.now().add(const Duration(days: 2))),
  Meal(name: "comida 4", protein: 9, calories: 25, carbs: 20, dateTime: DateTime.now().add(const Duration(days: 3))),
  Meal(name: "comida 5", protein: 6, calories: 22, carbs: 15, dateTime: DateTime.now().add(const Duration(days: 4))),
  Meal(name: "comida 6", protein: 10, calories: 30, carbs: 18, dateTime: DateTime.now().add(const Duration(days: 5))),
  Meal(name: "comida 7", protein: 4, calories: 16, carbs: 14, dateTime: DateTime.now().add(const Duration(days: 6))),
  Meal(name: "comida 8", protein: 8, calories: 28, carbs: 22, dateTime: DateTime.now().add(const Duration(days: 7))),
  Meal(name: "comida 9", protein: 2, calories: 14, carbs: 10, dateTime: DateTime.now().add(const Duration(days: 8))),
  Meal(name: "comida 10", protein: 1, calories: 12, carbs: 8, dateTime: DateTime.now().add(const Duration(days: 9))),
  Meal(name: "comida 11", protein: 6, calories: 24, carbs: 16, dateTime: DateTime.now().add(const Duration(days: 10))),
  Meal(name: "comida 12", protein: 9, calories: 30, carbs: 22, dateTime: DateTime.now().add(const Duration(days: 11))),
  Meal(name: "comida 13", protein: 3, calories: 15, carbs: 12, dateTime: DateTime.now().add(const Duration(days: 12))),
  Meal(name: "comida 14", protein: 7, calories: 26, carbs: 18, dateTime: DateTime.now().add(const Duration(days: 13))),
  Meal(name: "comida 15", protein: 2, calories: 12, carbs: 10, dateTime: DateTime.now().add(const Duration(days: 14))),
  Meal(name: "comida 16", protein: 10, calories: 32, carbs: 24, dateTime: DateTime.now().add(const Duration(days: 15))),
  Meal(name: "comida 17", protein: 5, calories: 20, carbs: 14, dateTime: DateTime.now().add(const Duration(days: 16)))
];

});
