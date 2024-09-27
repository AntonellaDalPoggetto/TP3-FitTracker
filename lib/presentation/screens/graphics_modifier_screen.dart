import 'package:flutter/material.dart';

class GraphicsModifierScreen extends StatelessWidget {
  static const String name = 'modificador de graficos';

  const GraphicsModifierScreen({super.key});

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