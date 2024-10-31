import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
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
        _selectedIndex = index; 
      });
      context.go(routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: widget.child, // Usa el widget actual de la ruta como hijo
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF67B69B), 
        unselectedItemColor: Colors.grey, 
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped, 
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
