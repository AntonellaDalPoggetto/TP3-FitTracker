import 'package:fittracker/presentation/entities/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ELIMINAR DATOS DE PRUEBAAAAAAAAAAAAAAA

StateProvider<List<Meal>> mealListProvider = StateProvider<List<Meal>>((ref) {
  return [
    Meal(
      name: 'Ensalada César',
      protein: 20.0,
      calories: 250.0,
      carbs: 10.0,
      dateTime: DateTime.now(),
    ),
    Meal(
      name: 'Pasta al Pesto',
      protein: 15.0,
      calories: 350.0,
      carbs: 60.0,
      dateTime: DateTime.now().subtract(Duration(days: 1)),
    ),
    Meal(
      name: 'Salmón a la Parrilla',
      protein: 30.0,
      calories: 400.0,
      carbs: 5.0,
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
    Meal(
      name: 'Tacos de Pollo',
      protein: 25.0,
      calories: 500.0,
      carbs: 45.0,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];
});
