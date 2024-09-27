import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String name = 'login';

  const Login({super.key});

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