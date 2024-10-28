import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserOptions extends StatelessWidget {
  static const String name = 'User Options';

  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Opciones de Usuario',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0, // Sombra debajo del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                // Navegar a la pantalla de perfil
                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Cambiar Contraseña'),
              onTap: () {
                // Navegar a la pantalla de cambiar contraseña
                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                // Navegar a la pantalla de notificaciones
                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Idioma'),
              onTap: () {
                // Navegar a la pantalla de selección de idioma
                context.go('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                // Navegar a la pantalla de información
                context.go('/home');
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Cerrar sesión
                // Implementar la lógica de cierre de sesión aquí
                context.go('/login');
              },
              child: const Text('Cerrar Sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Botón de ancho completo
              ),
            ),
          ],
        ),
      ),
    );
  }
}
