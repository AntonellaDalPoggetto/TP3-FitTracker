import 'package:flutter/material.dart';

class MealsListScreen extends StatelessWidget {
  static const String name = 'listado de comidas';

  const MealsListScreen({super.key});

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