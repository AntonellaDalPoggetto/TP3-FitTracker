import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/providers/auth_Provider.dart';
import 'package:go_router/go_router.dart';

class Register extends ConsumerStatefulWidget {
  static const String name = 'register';

  const Register({super.key});
  @override
  ConsumerState<Register> createState() => _RegistrationView();
}

class _RegistrationView extends ConsumerState<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    final auth = ref.read(authProvider);
    final user =
        await auth.register(_emailController.text, _passwordController.text);

    if (user != null) {
      context.go('/home'); // Cambia a la ruta que desees
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al registrarse')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF34D399) // Establecer el color del botón
                  ),
              child: Text( style: TextStyle(
                    color: Colors.grey[700],
                  ),'Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
