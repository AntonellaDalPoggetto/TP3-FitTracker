import 'package:fittracker/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserOptions extends ConsumerStatefulWidget {
  static const String name = 'User Options';

  const UserOptions({super.key});

  @override
  _UserOptionsView createState() => _UserOptionsView();
}

class _UserOptionsView extends ConsumerState<UserOptions> {
  _UserOptionsView();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Opciones de Usuario',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Cambiar Contraseña'),
              onTap: () {
                context.push('/home');       
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                context.push('/about_screen');
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                  final auth = ref.read(authProvider);
                  await auth.logout();
                context.go('/login');
              },
              child: const Text('Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
