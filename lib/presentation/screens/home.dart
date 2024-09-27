import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String name = 'Home';

  const Home({super.key});

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