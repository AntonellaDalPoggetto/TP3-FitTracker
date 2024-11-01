import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fittracker/presentation/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserFS?> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserNotifier(this._firestore, this._auth) : super(null) {
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore.collection('User').doc(user.uid).get();
      if (snapshot.exists) {
        state = UserFS.fromFirestore(snapshot);
      } else {
        state = null;
      }
    } else {
      state = null;
    }
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserFS?>((ref) {
  return UserNotifier(FirebaseFirestore.instance, FirebaseAuth.instance);
});
