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
  
  
  Future<void> changePassword(String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore.collection('User').doc(user.uid).update({'password': newPassword});
      }
    } 
    catch (e) {
      print('Error updating password: $e');
    }
  }

  addUser(UserFS userDB) async {   
    await _firestore.collection('User').doc(userDB.userID).set({
      'userID': userDB.userID,
      'username': userDB.username,
      'password': userDB.password,
      'lastLogin': userDB.lastLogin,
      'email': userDB.email,
    });  
  }
    
    
  Future<void> updateUser({String? newName, int? newImageId}) async {
    final user = _auth.currentUser;
    if (user != null && state != null) {
      try {
        final Map<String, dynamic> updates = {};
        if (newName != null) updates['username'] = newName;
        if (newImageId != null) updates['idImage'] = newImageId;
        await _firestore.collection('User').doc(user.uid).update(updates);

        state = state!.copyWith(
          username: newName ?? state!.username,
          idImage: newImageId ?? state!.idImage,
        );
      } catch (e) {
        print('Error updating user: $e');
      }
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserFS?>((ref) {
  return UserNotifier(FirebaseFirestore.instance, FirebaseAuth.instance);
});
