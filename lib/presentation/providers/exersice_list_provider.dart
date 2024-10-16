import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<List<Exercise>> exerciseListProvider = StateProvider<List<Exercise>>((ref) {
  return [
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 20, dateTime: DateTime.now()),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 30, dateTime: DateTime.now()),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now()),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 20, dateTime: DateTime.now().add(const Duration(days: 1))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 35, dateTime: DateTime.now().add(const Duration(days: 1))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 1))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 25, dateTime: DateTime.now().add(const Duration(days: 3))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 35, dateTime: DateTime.now().add(const Duration(days: 3))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 3))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 25, dateTime: DateTime.now().add(const Duration(days: 4))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 40, dateTime: DateTime.now().add(const Duration(days: 4))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 4))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 30, dateTime: DateTime.now().add(const Duration(days: 5))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 45, dateTime: DateTime.now().add(const Duration(days: 5))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 5))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 30, dateTime: DateTime.now().add(const Duration(days: 6))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 50, dateTime: DateTime.now().add(const Duration(days: 6))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 6))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 35, dateTime: DateTime.now().add(const Duration(days: 7))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 60, dateTime: DateTime.now().add(const Duration(days: 7))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 7))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 35, dateTime: DateTime.now().add(const Duration(days: 8))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 60, dateTime: DateTime.now().add(const Duration(days: 8))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 8))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 40, dateTime: DateTime.now().add(const Duration(days: 9))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 60, dateTime: DateTime.now().add(const Duration(days: 9))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 9))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 40, dateTime: DateTime.now().add(const Duration(days: 10))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 65, dateTime: DateTime.now().add(const Duration(days: 10))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 10))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 45, dateTime: DateTime.now().add(const Duration(days: 11))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 65, dateTime: DateTime.now().add(const Duration(days: 11))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 11))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 45, dateTime: DateTime.now().add(const Duration(days: 12))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 65, dateTime: DateTime.now().add(const Duration(days: 12))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 60, dateTime: DateTime.now().add(const Duration(days: 12))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 50, dateTime: DateTime.now().add(const Duration(days: 13))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 65, dateTime: DateTime.now().add(const Duration(days: 13))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 65, dateTime: DateTime.now().add(const Duration(days: 13))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 50, dateTime: DateTime.now().add(const Duration(days: 14))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 65, dateTime: DateTime.now().add(const Duration(days: 14))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 65, dateTime: DateTime.now().add(const Duration(days: 14))),
    
    Exercise(name: "Press de banca", sets: 3, reps: 5, weight: 50, dateTime: DateTime.now().add(const Duration(days: 15))),
    Exercise(name: "Sentadilla", sets: 3, reps: 8, weight: 70, dateTime: DateTime.now().add(const Duration(days: 15))),
    Exercise(name: "Dominadas", sets: 3, reps: 10, weight: 65, dateTime: DateTime.now().add(const Duration(days: 15))),
    
  ];
});
