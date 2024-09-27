import 'package:flutter/material.dart';

class UserOptions extends StatelessWidget {
  static const String name = 'usar options';

  const UserOptions({super.key});

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