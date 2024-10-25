import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



Future<User?> register(String email, String password) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    // Maneja errores específicos de Firebase
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
    // Otros errores que no sean de Firebase
    print('Error inesperado: $e');
    return null;
  }
}
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); 
      
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
