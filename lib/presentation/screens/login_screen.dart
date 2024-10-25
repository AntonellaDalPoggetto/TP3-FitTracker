import 'package:fittracker/presentation/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/providers/auth_Provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'login';
  const LoginScreen({super.key});

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginView();

  final snackBar = const SnackBar(
    content: Text('email and password do not match. Please try again.'),
    duration: Duration(seconds: 20),
  );

  void _login() async {
    final auth = ref.read(authProvider);
    final user = await auth.login(_emailController.text, _passwordController.text);
    if (user != null) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
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
                  hintText: 'email',
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
                  hintText: 'Password',
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
              onPressed: _login,
               style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF34D399) // Establecer el color del botón
                  ),
              child: const Text('Login'),
            ),
             const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()), // Cambia esto por tu página de registro
              );
            },
            child: const Text(
              '¿No tienes una cuenta? Regístrate',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
