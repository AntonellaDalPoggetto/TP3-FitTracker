import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/entities/meal.dart';

class MealListNotifier extends StateNotifier<List<Meal>> {

  MealListNotifier() : super([]);
  final firestore = FirebaseFirestore.instance;

  Future<void> addMeal(Meal meal) async {
      
    final doc = firestore.collection('Meal').doc();
    try {
      await doc.set(meal.toFirestore());
      state = [...state, meal];
    } catch (e) {
      print(e);
    }
  }  

  Future<void> getAllMeals() async {

    final docs = firestore.collection('Meal').withConverter(
        fromFirestore: Meal.fromFirestore,
        toFirestore: (Meal meal, _) => meal.toFirestore());
    final meals = await docs.get();
    state = [...state, ...meals.docs.map((d) => d.data())];
  }

  void filterByName(String query) {
    if (query.isEmpty) {
      getAllMeals();
    } else {
      state = state
          .where((meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

final mealListProvider = StateNotifierProvider<MealListNotifier, List<Meal>>((ref) {
  final notifier = MealListNotifier();
  notifier.getAllMeals();
  return notifier;
});
