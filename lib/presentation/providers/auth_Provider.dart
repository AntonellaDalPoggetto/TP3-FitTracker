import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentUsername = "";

  Future<User?> register(String email, String password, String username) async 
  {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
      User? user = userCredential.user;
      String hashedpassword = sha256.convert(utf8.encode(password)).toString();

      if (user != null) {
        await _firestore.collection('User').doc(user.uid).set({
          'userID': user.uid,
          'username': username,
          'password': hashedpassword,
          'lastLogin': DateTime.now(),
          'email': email,
        });
      }
      currentUsername = username;
      return user;
      }
      on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('El correo electrónico ya está en uso.');
      } else if (e.code == 'weak-password') {
        print('La contraseña es demasiado débil.');
      } else if (e.code == 'invalid-email') {
        print('El correo electrónico no es válido.');
      } else {
        print('Error al registrar: $e');
      }
      return null;
    } catch (e) {
      print('Error inesperado: $e');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
      
      return userCredential.user;
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