import 'package:flutter/material.dart';

class MealsRegistrationScreen extends StatelessWidget {
  static const String name = 'registro de comidas';

  const MealsRegistrationScreen({super.key});

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