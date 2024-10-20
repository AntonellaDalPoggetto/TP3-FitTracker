import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  static const String name = 'Home';

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Para mantener el índice de la página seleccionada

  // Aquí defines las páginas que se mostrarán según el índice
  static const List<Widget> _widgetOptions = <Widget>[
    _BodyView(), // Página principal
    Text('Comidas'), // Página de comidas
    Text('Ejercicio'), // Página de ejercicio
    Text('Estadísticas'), // Página de estadísticas
    Text('Perfil'), // Página de perfil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soy el ${_widgetOptions[_selectedIndex]}'),
      ),
      body: SlidingUpPanel(
        panel: const _Graph(), // Aquí va tu gráfico completo
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF0F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)), 
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              _Graph(),
              Center(child: Text("Desliza hacia arriba para ver más")),
            ],
          ),
        ),
        body: _widgetOptions[_selectedIndex], // Cambia el contenido según el índice seleccionado
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), 
        minHeight: 440, 
        maxHeight: 800, 
        defaultPanelState: PanelState.CLOSED,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Fondo oscuro para la barra de navegación
        selectedItemColor: const Color(0xFF67B69B), // Color verde para el ícono seleccionado
        unselectedItemColor: Colors.grey, // Color gris para íconos no seleccionados
        currentIndex: _selectedIndex, // Asegúrate de que esta variable se actualice correctamente
        onTap: _onItemTapped, // Llama a tu función para manejar el toque
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Comidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}


// Widget de encabezado que contiene el saludo, foto y subtítulo
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // Fondo blanco
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          // Foto de perfil
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://example.com/tu-foto.jpg'), // Reemplaza con la URL de tu foto
          ),
          const SizedBox(width: 16), // Espacio entre la foto y el texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Hola, Usuario!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Bienvenido de nuevo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Primer carrusel con 6 botones
      CarouselSlider(
        options: CarouselOptions(
          height: 150.0, // Altura del carrusel
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          enableInfiniteScroll: false,
        ),
        items: [
          // Primera slide con 3 botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_registration');
                  },
                  child: const Text('Agregar Comida'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_list');
                  },
                  child: const Text('Botón 2'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_list');
                  },
                  child: const Text('Botón 3'),
                ),
              ),
            ],
          ),
          // Segunda slide con 3 botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_list');
                  },
                  child: const Text('Botón 4'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_list');
                  },
                  child: const Text('Botón 5'),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meals_list');
                  },
                  child: const Text('Ver Historial'),
                ),
              ),
            ],
          ),
        ],
      ),
      // Segundo carrusel con un botón y un rectángulo redondeado
      CarouselSlider(
        options: CarouselOptions(
          height: 75.0, // Altura del carrusel reducida
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          enableInfiniteScroll: false,
        ),
        items: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/exercise_registration');
                  },
                  child: const Text('Añadir Ejercicio'),
                ),
              ),
              SizedBox(
                height: 60,
                width: 220,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '80% de Metas Alcanzadas',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 220,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '80% de Metas Alcanzadas',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/exercises_list');
                  },
                  child: const Text('Ver Historial'),
                ),
              ),
            ],
          ),
        ],
      ),
      const Text("Calorías x día"),
    ]);
  }
}

class _Graph extends ConsumerWidget {
  const _Graph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> meals = ref.watch(mealListProvider);

    // Crear datos para el gráfico de barras
    List<BarChartGroupData> barGroups = meals.asMap().entries.map((entry) {
      int index = entry.key;
      Meal meal = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: meal.protein, 
            color: Colors.amber,
            width: 8, 
            borderRadius: BorderRadius.zero, 
          )
        ],
      );
    }).toList();

    final shownDates = <String>{};

    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final int index = value.toInt();
                    if (index < 0 || index >= meals.length) return const Text('');

                    final String date = meals[index].dateTime.toString();
                    if (shownDates.contains(date)) return const Text('');

                    shownDates.add(date);
                    return Text(date);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
