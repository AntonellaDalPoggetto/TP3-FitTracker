import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/auth_provider.dart';

class MealListNotifier extends StateNotifier<List<Meal>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  MealListNotifier(this._authService) : super([]);

  Future<void> deleteMeal(String mealID) async {
    try {
      await _firestore.collection('Meal').doc(mealID).delete();
      state = state.where((m) => m.mealID != mealID).toList();
      _sortMealsByDate();
    } catch (e) {
      print('Error al eliminar la comida: $e');
    }
  }

  Future<void> addMeal(Meal meal) async {
    final currentUser = _authService.currentUser;
    final doc = _firestore.collection('Meal').doc();

    if (currentUser != null) {
      meal.userID = currentUser.uid;
    }
    try {
      meal.mealID = doc.id;
      await doc.set(meal.toFirestore());
      state = [...state, meal];
      _sortMealsByDate();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllMeals() async {
    final currentUser = _authService.currentUser;

    if (currentUser != null) {
      final docs = _firestore
          .collection('Meal')
          .where('userID', isEqualTo: currentUser.uid)
          .withConverter(
              fromFirestore: Meal.fromFirestore,
              toFirestore: (Meal meal, _) => meal.toFirestore());

      final meals = await docs.get();
      state = meals.docs.map((d) => d.data()).toList();
      _sortMealsByDate();
    }
  }

  void filterByName(String query) {
    if (query.isEmpty) {
      getAllMeals();
    } else {
      state = state
          .where((meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _sortMealsByDate();
    }
  }

  void _sortMealsByDate() {
    state = [...state]..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  void clearState() {
    state = [];
  }
}

final mealListProvider = StateNotifierProvider<MealListNotifier, List<Meal>>((ref) {
  final authService = ref.read(authProvider);
  final notifier = MealListNotifier(authService);
  notifier.getAllMeals();
  return notifier;
});
