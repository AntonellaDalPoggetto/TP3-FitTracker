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

  // Future<void> getAllMeals() async {
  //   try {
  //     final querySnapshot = await firestore.collection('Meal').get();

  //     final meals = querySnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return Meal(
  //         name: data['name'] ?? '',
  //         protein: (data['protein'] ?? 0).toDouble(),
  //         calories: (data['calories'] ?? 0).toDouble(),
  //         carbs: (data['carbs'] ?? 0).toDouble(),
  //         dateTime: (data['dateTime'] as Timestamp).toDate(),
  //       );
  //     }).toList();
      
  //     state = meals;
  //   } catch (e) {      
  //     print("Error al cargar las comidas desde Firebase: $e");
  //   }
  // }

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
