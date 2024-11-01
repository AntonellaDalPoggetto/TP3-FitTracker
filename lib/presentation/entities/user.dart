import 'package:cloud_firestore/cloud_firestore.dart';

class UserFS {
  final String username;
  final String password;
  final String userID;
  final String email;
  final DateTime lastLogin;

  UserFS({
    required this.username,
    required this.password,
    required this.userID,
    required this.email,
    required this.lastLogin
  });

  

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'password': password,
      'lastLogin': lastLogin,
      'userID': userID,
      'email': email,
    };
  }

  static UserFS fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserFS(
      username: data?['username'] ?? '',
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      lastLogin: (data?['lastLogin'] as Timestamp).toDate(),
      userID: (data?['userID'] ?? ''),
    );
  }
}