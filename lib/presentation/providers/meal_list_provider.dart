import 'package:fittracker/presentation/entities/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ELIMINAR DATOS DE PRUEBAAAAAAAAAAAAAAA

StateProvider<List<Meal>> mealListProvider = StateProvider<List<Meal>>((ref) {
  return [
    Meal(name: "", protein: 0, calories: 0, carbs: 0, dateTime: DateTime.now())
  ];
});
