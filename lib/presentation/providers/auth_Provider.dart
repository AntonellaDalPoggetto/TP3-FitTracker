import 'package:fittracker/presentation/providers/chart_provider.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fittracker/presentation/providers/user_Provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

final authProvider = Provider<AuthService>((ref) => AuthService(ref));

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Ref ref;

  AuthService(this.ref);

  String currentUsername = "";

  Future<User?> register(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      String hashedPassword = sha256.convert(utf8.encode(password)).toString();

      if (user != null) {
        await _firestore.collection('User').doc(user.uid).set({
          'userID': user.uid,
          'username': username,
          'password': hashedPassword,
          'lastLogin': DateTime.now(),
          'email': email,
        });
        currentUsername = username;
        
        final userNotifier = ref.read(userProvider.notifier);
        await userNotifier.getCurrentUser();
      }
      return user;
    } catch (e) {
      print('Error al registrar: $e');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email,password: password);
      final user = userCredential.user;
      
      if (user != null) {
        final userNotifier = ref.read(userProvider.notifier);
        await userNotifier.getCurrentUser();
        ref.read(mealListProvider.notifier).getAllMeals();  
        ref.read(exerciseListProvider.notifier).getAllExercises();
        ref.read(chartListProvider.notifier).getAllCharts();
      }
      return user;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    ref.read(mealListProvider.notifier).clearState();    
    ref.read(exerciseListProvider.notifier).clearState();   
    ref.read(chartListProvider.notifier).clearState();   
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
