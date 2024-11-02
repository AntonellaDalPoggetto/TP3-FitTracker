import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String userID;
  final String name;
  final double protein;
  final double calories;
  final double carbs;
  final DateTime dateTime;

  Meal({
    required this.name,
    required this.userID,
    required this.protein,
    required this.calories,
    required this.carbs,
    required this.dateTime,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'userID': userID,
      'protein': protein,
      'calories': calories,
      'carbs': carbs,
      'dateTime': dateTime,
    };
  }

  static Meal fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Meal(
      name: data?['name'] ?? '',
      userID: data?['userID'] ?? '',
      protein: (data?['protein']?? 0).toDouble(),
      calories: (data?['calories'] ?? 0).toDouble(),
      dateTime: (data?['dateTime'] as Timestamp).toDate(),
      carbs: (data?['carbs'] ?? 0).toDouble(),
    );
  }
}