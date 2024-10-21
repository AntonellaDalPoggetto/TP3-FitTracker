import 'package:fittracker/presentation/entities/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


StateProvider<List<Meal>> mealListProvider = StateProvider<List<Meal>>((ref) {
  return [
  // Meal(name: "Ensalada César", protein: 15.0, calories: 300.0, carbs: 10.0, dateTime: DateTime.now()),
  // Meal(name: "Pollo a la parrilla", protein: 35.0, calories: 400.0, carbs: 0.0, dateTime: DateTime.now().add(const Duration(days: 1))),
  // Meal(name: "Pasta con tomate", protein: 10.0, calories: 500.0, carbs: 70.0, dateTime: DateTime.now().add(const Duration(days: 2))),
  // Meal(name: "Salmón al horno", protein: 30.0, calories: 450.0, carbs: 0.0, dateTime: DateTime.now().add(const Duration(days: 3))),
  // Meal(name: "Taco de carne", protein: 20.0, calories: 250.0, carbs: 30.0, dateTime: DateTime.now().add(const Duration(days: 4))),
  // Meal(name: "Arroz con pollo", protein: 25.0, calories: 600.0, carbs: 80.0, dateTime: DateTime.now().add(const Duration(days: 5))),
  // Meal(name: "Sushi de atún", protein: 18.0, calories: 350.0, carbs: 40.0, dateTime: DateTime.now().add(const Duration(days: 6))),
  // Meal(name: "Batido de proteínas", protein: 25.0, calories: 200.0, carbs: 15.0, dateTime: DateTime.now().add(const Duration(days: 7))),
  // Meal(name: "Tortilla de verduras", protein: 12.0, calories: 250.0, carbs: 20.0, dateTime: DateTime.now().add(const Duration(days: 8))),
  // Meal(name: "Pancakes de avena", protein: 8.0, calories: 350.0, carbs: 60.0, dateTime: DateTime.now().add(const Duration(days: 9))),
  // Meal(name: "Hamburguesa con queso", protein: 22.0, calories: 700.0, carbs: 40.0, dateTime: DateTime.now().add(const Duration(days: 10))),
  // Meal(name: "Pizza de pepperoni", protein: 18.0, calories: 500.0, carbs: 60.0, dateTime: DateTime.now().add(const Duration(days: 11))),
  // Meal(name: "Batido de frutas", protein: 5.0, calories: 150.0, carbs: 35.0, dateTime: DateTime.now().add(const Duration(days: 12))),
  // Meal(name: "Quinoa con verduras", protein: 12.0, calories: 300.0, carbs: 40.0, dateTime: DateTime.now().add(const Duration(days: 13))),
  // Meal(name: "Guiso de lentejas", protein: 20.0, calories: 400.0, carbs: 60.0, dateTime: DateTime.now().add(const Duration(days: 14))),
  // Meal(name: "Filete de res", protein: 30.0, calories: 500.0, carbs: 0.0, dateTime: DateTime.now().add(const Duration(days: 15))),
  // Meal(name: "Yogur con frutas", protein: 10.0, calories: 200.0, carbs: 25.0, dateTime: DateTime.now().add(const Duration(days: 16))),
  // Meal(name: "Ensalada de garbanzos", protein: 15.0, calories: 300.0, carbs: 40.0, dateTime: DateTime.now().add(const Duration(days: 17))),
];


});
