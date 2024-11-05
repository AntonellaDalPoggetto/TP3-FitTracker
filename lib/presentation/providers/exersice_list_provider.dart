import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/providers/auth_provider.dart';

class ExerciseListNotifier extends StateNotifier<List<Exercise>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;

  ExerciseListNotifier(this._authService) : super([]);

  Future<void> deleteExercise(String exerciseID) async {
    try {
      await _firestore.collection('Exercise').doc(exerciseID).delete();
      state = state.where((e) => e.exerciseID != exerciseID).toList();
      _sortExercisesByDate();
    } catch (e) {
      print('Error al eliminar la comida: $e');
    }
  }

  Future<void> addExercise(Exercise ex) async {
    final currentUser = _authService.currentUser;
    final doc = _firestore.collection('Exercise').doc();

    if (currentUser != null) {
      ex.userID = currentUser.uid;
    }
    try {
      ex.exerciseID = doc.id;
      await doc.set(ex.toFirestore());
      state = [...state, ex];
      _sortExercisesByDate();
    } catch (e) {
      print(e);
    }
  }

  void filterByName(String query) {
    if (query.isEmpty) {
      getAllExercises();
    } else {
      state = state
          .where((exercise) => exercise.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _sortExercisesByDate();
    }
  }

  Future<void> getAllExercises() async {
    final currentUser = _authService.currentUser;

    if (currentUser != null) {
      final docs = _firestore
          .collection('Exercise')
          .where('userID', isEqualTo: currentUser.uid)
          .withConverter(
              fromFirestore: Exercise.fromFirestore,
              toFirestore: (Exercise exercise, _) => exercise.toFirestore());

      final exercises = await docs.get();
      state = exercises.docs.map((d) => d.data()).toList();
      _sortExercisesByDate();
    }
  }

  void _sortExercisesByDate() {
    state = [...state]..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  void clearState() {
    state = [];
  }
}

final exerciseListProvider =
    StateNotifierProvider<ExerciseListNotifier, List<Exercise>>((ref) {
  final authService = ref.read(authProvider);
  final notifier = ExerciseListNotifier(authService);
  notifier.getAllExercises();
  return notifier;
});
