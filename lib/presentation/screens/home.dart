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
  final int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _BodyView(), // Página principal
    Text('Comidas'),
    Text('Ejercicio'),
    Text('Estadísticas'),
    Text('Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double minHeight = screenHeight * 0.5; // 44% de la altura de la pantalla
    double maxHeight = screenHeight * 0.88; // 88% de la altura de la pantalla

    return Scaffold(
      appBar: AppBar(
        title: _Header(),
      ),
      body: SlidingUpPanel(
        panel: Padding(
          padding: const EdgeInsets.all(16.0), // Agrega un padding para que se vea mejor
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Primer gráfico
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight *0.25,
                    child: const _Graph(),
                  ),
                  // Segundo gráfico
                  SizedBox(
                  width: screenWidth * 0.4,
                    height: screenHeight *0.25,
                    child: const _Graph(),
                  ),
                ],
              ),
              SizedBox(
               width: screenWidth * 0.4,
                    height: screenHeight *0.5,
                child: const _Graph(), // Tercer gráfico
              ),
            ],
          ),
        ),
      
collapsed: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF0F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight *0.25,
                    child: const _Graph(),
                  ),
              SizedBox(height: 10),
              Center(child: Text("Desliza hacia arriba para ver más")),
            ],
          ),
        ),
        
        body: Column(
          children: [
            Expanded(
              child: _widgetOptions[_selectedIndex], //no se como funciona pero es todo lo de los carrouseles y eso
            ),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        minHeight: minHeight,
        maxHeight: maxHeight,
        defaultPanelState: PanelState.CLOSED,
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
            backgroundImage: NetworkImage(
                'https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png'), // Reemplaza con la URL de tu foto
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
    Color colorGreen = const Color(0xFF34D399);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Primer carrusel con 6 botones
        LayoutBuilder(
          builder: (context, constraints) {
            double carouselHeight = screenHeight * 0.2;
            double buttonHeight = carouselHeight * 0.7;
            double buttonWidth = carouselHeight * 0.6;

            return CarouselSlider(
              options: CarouselOptions(
                height: carouselHeight,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
              ),
              items: _buildCarouselItems(buttonHeight, buttonWidth, colorGreen, context),
            );
          },
        ),

        // Segundo carrusel con un botón y un rectángulo redondeado
        CarouselSlider(
          options: CarouselOptions(
            height: 75.0,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            enableInfiniteScroll: false,
          ),
          items: _buildSecondaryCarousel(screenHeight, screenWidth, colorGreen, context),
        ),
      ],
    );
  }

  List<Widget> _buildCarouselItems(double buttonHeight, double buttonWidth, Color colorGreen, BuildContext context) {
  return [
    _buildButtonRow(buttonHeight, buttonWidth, colorGreen, context, [
      'Agregar Comida',
      'Botón 2',
      'Botón 3',
    ]),
    _buildButtonRow(buttonHeight, buttonWidth, colorGreen, context, [
      'Botón 4',
      'Botón 5',
      'Ver Historial',
    ]),
  ];
}

Row _buildButtonRow(double height, double width, Color colorGreen, BuildContext context, List<String> buttonLabels) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: buttonLabels.map((label) {
      if (label == 'Agregar Comida') {
        return _buildSingleButton(height, width, colorGreen, context);
      } else if (label == 'Ver Historial') {
        return _buildStackedIconButton(height, width, colorGreen, context, label, Icons.history);
      } else {
        return _buildStandardButton(height, width, colorGreen, context, label);
      }
    }).toList(),
  );
}

SizedBox _buildSingleButton(double height, double width, Color colorGreen, BuildContext context) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        ElevatedButton(
          onPressed: () {
            context.go('/meals_registration');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: colorGreen,
              width: 2,
            ),
            backgroundColor: Colors.white,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 8),
              Text(
                'Agregar Comida',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(
          top: height * 0.1,
          child: Container(
            width: height * 0.5,
            height: height * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: InkWell(
                onTap: () {
                  context.go('/meals_registration');
                },
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

SizedBox _buildStandardButton(double height, double width, Color colorGreen, BuildContext context, String label) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      onPressed: () {
        context.go('/meals_list');
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: colorGreen,
          width: 2,
        ),
        backgroundColor: Colors.white,
      ),
      child: Text(label, textAlign: TextAlign.center),
    ),
  );
}

SizedBox _buildStackedIconButton(double height, double width, Color colorGreen, BuildContext context, String label, IconData icon) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _buildStandardButton(height, width, colorGreen, context, label),
        Positioned(
          top: height * 0.1,
          child: _buildCircularIcon(colorGreen, context, icon, () {
            context.go('/meals_list');
          }),
        ),
      ],
    ),
  );
}

Widget _buildCircularIcon(Color colorGreen, BuildContext context, dynamic content, VoidCallback onTap) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: colorGreen,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Center(
      child: InkWell(
        onTap: onTap,
        child: content is String
            ? Text(
                content,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : Icon(
                content,
                size: 24,
                color: Colors.white,
              ),
      ),
    ),
  );
}


  List<Widget> _buildSecondaryCarousel(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return [
    _buildExerciseButtonRow(screenHeight, screenWidth, colorGreen, context),
    _buildHistoryButtonRow(screenHeight, screenWidth, colorGreen, context), // Agregar la fila para el botón de historial
  ];
}

Row _buildExerciseButtonRow(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildExerciseButton(screenHeight, screenWidth, colorGreen, context),
      _buildProgressContainer(screenHeight, screenWidth),
    ],
  );
}

Row _buildHistoryButtonRow(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
            _buildProgressContainer(screenHeight, screenWidth),
            _buildHistoryButton(screenHeight, screenWidth, colorGreen, context), // Botón de ver historial
    ],
  );
}

SizedBox _buildExerciseButton(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return SizedBox(
    height: screenHeight * 0.6,
    width: screenWidth * 0.4,
    child: ElevatedButton(
      onPressed: () {
        context.go('/exercise_registration');
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: colorGreen,
          width: 2,
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCircularIcon(colorGreen, context, '+', () {
            context.go('/exercise_registration');
          }),
          const SizedBox(width: 8),
          const Text(
            'Añadir\nEjercicio',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}

// Nueva función para el botón de "Ver Historial"
SizedBox _buildHistoryButton(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return SizedBox(
    height: screenHeight * 0.6,
    width: screenWidth * 0.4,
    child: ElevatedButton(
      onPressed: () {
        context.go('/exercises_list'); // Cambia la ruta según sea necesario
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: colorGreen,
          width: 2,
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.history, color: Colors.black), // Puedes cambiar el ícono según sea necesario
          const SizedBox(width: 8),
          const Text(
            'Ver\nHistorial',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}


  SizedBox _buildProgressContainer(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.4,
      width: screenWidth * 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: const Color(0xFF34D399),
            width: 2,
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          '80% de Metas Alcanzadas',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}


class _Graph extends ConsumerWidget {
  const _Graph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> meals = ref.watch(mealListProvider); // Obteniendo la lista de comidas

    // Crear datos para el gráfico de barras
    List<BarChartGroupData> barGroups = meals.asMap().entries.map((entry) {
      int index = entry.key;
      Meal meal = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: meal.protein, // Asume que tienes una propiedad 'protein' en Meal
            color: Colors.amber,
            width: 8,
            borderRadius: BorderRadius.zero,
          ),
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
