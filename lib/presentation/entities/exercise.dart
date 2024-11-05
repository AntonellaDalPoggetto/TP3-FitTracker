import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  String? userID;
  String? exerciseID;
  final String name;
  final int sets;
  final int reps;
  final double weight;
  final DateTime dateTime;

  Exercise({
      required this.name,
      this.userID,
      this.exerciseID,
      required this.sets,
      required this.reps,
      required this.weight,
      required this.dateTime
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'userID': userID,
      'exerciseID': exerciseID,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'dateTime': dateTime,
    };
  }

  static Exercise fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Exercise(
      name: data?['name'] ?? '',
      userID: data?['userID'] ?? '',
      exerciseID: data?['exerciseID'] ?? '',
      sets: (data?['sets']?? 0).toInt(),
      reps: (data?['reps'] ?? 0).toInt(),
      weight: (data?['weight'] ?? 0).toDouble(),
      dateTime: (data?['dateTime'] as Timestamp).toDate(),
    );
  }

}
