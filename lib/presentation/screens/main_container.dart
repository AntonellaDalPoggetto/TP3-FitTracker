import 'package:fittracker/presentation/screens/exercises_list_screen.dart';
import 'package:fittracker/presentation/screens/graphics_modifier_screen.dart';
import 'package:fittracker/presentation/screens/home.dart';
import 'package:fittracker/presentation/screens/meals_list_screen.dart';
import 'package:fittracker/presentation/screens/user_options.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  MainContainerState createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    Home(),
    MealsListScreen(),
    GraphicsModifierScreen(),
    ExercisesListScreen(),
    UserOptions(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
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
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF67B69B),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Comidas'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Gráficos'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Ejercicios'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
