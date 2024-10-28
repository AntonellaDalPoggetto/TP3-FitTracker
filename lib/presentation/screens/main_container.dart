import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainContainer extends StatefulWidget {
  final Widget child;

  const MainContainer({super.key, required this.child});

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  static final List<String> routes = <String>[
    '/home',
    '/meals_list',
    '/graphics_modifier',
    '/exercises_list',
    '/user_options',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Actualiza el índice según la ruta actual para mostrar el ítem correcto
    final currentLocation = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final currentIndex = routes.indexOf(currentLocation);

    if (currentIndex != -1 && currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = currentIndex;
      });
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index; // Actualiza el índice seleccionado
      });
      context.go(routes[index]); // Navega a la ruta correspondiente
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // Pantalla actual
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Fondo oscuro para la barra de navegación
        selectedItemColor: const Color(0xFF67B69B), // Color verde para el ícono seleccionado
        unselectedItemColor: Colors.grey, // Color gris para íconos no seleccionados
        currentIndex: _selectedIndex, // Índice actual
        onTap: _onItemTapped, // Llama a la función cuando un ítem es seleccionado
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Comidas'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Graphics'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Exercises'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}