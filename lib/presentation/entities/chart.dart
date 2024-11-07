import 'package:cloud_firestore/cloud_firestore.dart';

class Chart {
  String? chartID;
  String? userID;
  final String name;
  final String variable;
  final DateTime? dateTime;

  Chart({
    required this.name,
    this.chartID,
    this.userID,
    required this.variable,
    required this.dateTime,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'chartID': chartID,
      'userID': userID,
      'name': name,
      'variable': variable,
      'dateTime': dateTime,
    };
  }

  static Chart fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Chart(
      chartID: data?['chartID'] ?? '',
      userID: data?['userID'] ?? '',
      name: data?['name'] ?? '',
      variable: (data?['variable']?? ''),
      dateTime: (data?['dateTime'] != null)? (data?['dateTime'] as Timestamp).toDate(): DateTime.now()
    );
  }
}