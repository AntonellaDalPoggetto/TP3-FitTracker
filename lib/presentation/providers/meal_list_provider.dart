import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/auth_provider.dart';

class MealListNotifier extends StateNotifier<List<Meal>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  

  MealListNotifier(this._authService) : super([]);

  Future<void> addMeal(Meal meal) async {      
    final currentUser = _authService.currentUser;
    if(currentUser != null){
      meal.userID = currentUser.uid;
    }

    final doc = _firestore.collection('Meal').doc();
    try {
      await doc.set(meal.toFirestore());
      state = [...state, meal];
    } 
    catch (e) {
      print(e);
    }
  }  

  Future<void> getAllMeals() async {
    final currentUser = _authService.currentUser;

    if(currentUser != null){      
      final docs = _firestore.collection('Meal').where('userID', isEqualTo: currentUser.uid)
      .withConverter(fromFirestore: Meal.fromFirestore, toFirestore: (Meal meal, _) => meal.toFirestore());

      final meals = await docs.get();
      state = [...meals.docs.map((d) => d.data())];
    }
  }

  void filterByName(String query) {
    if (query.isEmpty) {
      getAllMeals();
    } 
    else {
      state = state.where((meal) => meal.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
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