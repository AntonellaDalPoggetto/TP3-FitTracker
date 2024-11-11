import 'package:cloud_firestore/cloud_firestore.dart';

class UserFS {
  final String username;
  final String password;
  final String userID;
  final String email;
  final DateTime lastLogin;
  final int idImage;

  UserFS({
    required this.username,
    required this.password,
    required this.userID,
    required this.email,
    required this.lastLogin,
    this.idImage = 1,
  });

  

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'password': password,
      'lastLogin': lastLogin,
      'userID': userID,
      'email': email,
      'idImage': idImage,
    };
  }
  
  factory UserFS.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserFS(
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
      userID: (data['userID'] ?? ''),
      idImage: data['idImage'] ?? 1,
    );
  }

  String? get imageUrl => null;

  UserFS copyWith({
    String? userID,
    String? username,
    String? password,
    DateTime? lastLogin,
    String? email,
    int? idImage,
  }) {
    return UserFS(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      password: password ?? this.password,
      lastLogin: lastLogin ?? this.lastLogin,
      email: email ?? this.email,
      idImage: idImage ?? this.idImage,
    );
  }
}
