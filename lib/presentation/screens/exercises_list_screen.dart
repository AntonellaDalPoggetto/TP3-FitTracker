import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExercisesListScreen extends StatelessWidget {
  static const String name = 'listado de ejercicios';

  const ExercisesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soy el $name'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: const Center(
        child: Text('Contenido del $name'),
      ),
    );
  }
}