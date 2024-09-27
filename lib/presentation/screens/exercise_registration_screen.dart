import 'package:flutter/material.dart';

class ExerciseRegistrationScreen extends StatelessWidget {
  static const String name = 'registro de ejercicios';

  const ExerciseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soy el $name'),
      ),
      body: const Center(
        child: Text('Contenido del $name'),
      ),
    );
  }
}