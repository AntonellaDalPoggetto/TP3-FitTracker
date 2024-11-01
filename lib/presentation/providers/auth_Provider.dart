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
  final Ref ref; // Guarda una referencia de ref para acceder a otros providers

  AuthService(this.ref); // Acepta ref en el constructor

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

        // Actualiza el userProvider después de registrar
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
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
      final user = userCredential.user;

      // Actualiza el userProvider después de iniciar sesión
      if (user != null) {
        final userNotifier = ref.read(userProvider.notifier);
        await userNotifier.getCurrentUser();
      }
      return user;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
