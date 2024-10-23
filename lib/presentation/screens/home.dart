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
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _BodyView(), // Página principal
    Text('Comidas'),
    Text('Ejercicio'),
    Text('Estadísticas'),
    Text('Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double minHeight = screenHeight * 0.44; // 44% de la altura de la pantalla
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    child: const _Graph(),
                  ),
                  // Segundo gráfico
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 100,
                    child: const _Graph(),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
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
                width: 60,
                height: 60,
                child: const _Graph(), // Gráfico en estado colapsado
              ),
              SizedBox(height: 10),
              Center(child: Text("Desliza hacia arriba para ver más")),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: _widgetOptions[_selectedIndex],
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
                'https://example.com/tu-foto.jpg'), // Reemplaza con la URL de tu foto
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
            double screenHeight = MediaQuery.of(context).size.height;
            double screenWidth = MediaQuery.of(context).size.width;
            double carouselHeight = screenHeight *
                0.2; // Usa el maxHeight disponible del LayoutBuilder
            double height1 = carouselHeight * 0.7;
            double width1 = carouselHeight * 0.6; // 88% de la altura disponible

            return CarouselSlider(
              options: CarouselOptions(
                height:
                    carouselHeight, // Usa minHeight para la altura del carrusel
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
                      height: height1,
                      width: width1,
                      child: Stack(
                        alignment: Alignment
                            .topCenter, // Centra el contenido en la parte superior
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.go('/meals_registration');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Bordes redondeados
                              ),
                              side: BorderSide(
                                color: colorGreen, // Color del borde
                                width: 2, // Grosor del borde
                              ),
                              backgroundColor:
                                  Colors.white, // Color de fondo del botón
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Alinea los elementos al final
                              children: [
                                SizedBox(
                                    height:
                                        8), // Espacio superior para centrar el texto
                                Text(
                                  'Agregar Comida',
                                  textAlign: TextAlign
                                      .center, // Alinea el texto al centro
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: height1 *
                                0.1, // Ajusta este valor para posicionar el '+' donde lo necesites
                            child: Container(
                              width: height1 *
                                  0.5, // Ajusta el tamaño según sea necesario
                              height: height1 *
                                  0.5, // Ajusta el tamaño según sea necesario
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorGreen, // Color de fondo del círculo
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
                                    context.go(
                                        '/meals_registration'); // Acción al presionar el texto
                                  },
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize:
                                          34, // Ajusta el tamaño del texto
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height1,
                      width: width1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/meals_list');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                          side: BorderSide(
                            color: colorGreen, // Color del borde
                            width: 2, // Grosor del borde
                          ),
                          backgroundColor:
                              Colors.white, // Color de fondo del botón
                        ),
                        child: const Text('Botón 2'),
                      ),
                    ),
                    SizedBox(
                      height: height1,
                      width: width1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/meals_list');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                          side: BorderSide(
                            color: colorGreen, // Color del borde
                            width: 2, // Grosor del borde
                          ),
                          backgroundColor:
                              Colors.white, // Color de fondo del botón
                        ),
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
                      height: height1,
                      width: width1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/meals_list');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                          side: const BorderSide(
                            color: Color(0xFF34D399), // Color del borde
                            width: 2, // Grosor del borde
                          ),
                          backgroundColor:
                              Colors.white, // Color de fondo del botón
                        ),
                        child: const Text('Botón 4'),
                      ),
                    ),
                    SizedBox(
                      height: height1,
                      width: width1,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/meals_list');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                          side: BorderSide(
                            color: colorGreen, // Color del borde
                            width: 2, // Grosor del borde
                          ),
                          backgroundColor:
                              Colors.white, // Color de fondo del botón
                        ),
                        child: const Text('Botón 5'),
                      ),
                    ),
                    SizedBox(
                      height: height1,
                      width: width1,
                      child: Stack(
                        alignment: Alignment
                            .topCenter, // Centra el contenido en la parte superior
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.go(
                                  '/meals_list'); // Cambia la ruta a historial
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Bordes redondeados
                              ),
                              side: BorderSide(
                                color: colorGreen, // Color del borde
                                width: 2, // Grosor del borde
                              ),
                              backgroundColor:
                                  Colors.white, // Color de fondo del botón
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Alinea los elementos al final
                              children: [
                                SizedBox(
                                    height:
                                        8), // Espacio superior para centrar el texto
                                Text(
                                  'Ver Historial', // Cambia el texto a "Ver Historial"
                                  textAlign: TextAlign
                                      .center, // Alinea el texto al centro
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: height1 *
                                0.1, // Ajusta este valor para posicionar el ícono
                            child: Container(
                              width: height1 *
                                  0.5, // Ajusta el tamaño según sea necesario
                              height: height1 *
                                  0.5, // Ajusta el tamaño según sea necesario
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorGreen, // Color de fondo del círculo
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
                                    context.go(
                                        '/meals_list'); // Acción al presionar el ícono
                                  },
                                  child: const Icon(
                                    Icons
                                        .history, // Cambia el texto '+' por el icono del historial
                                    size:
                                        34, // Ajusta el tamaño del icono según lo necesites
                                    color: Colors.white, // Color del icono
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
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
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/exercise_registration');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Bordes redondeados
                      ),
                      side: BorderSide(
                        color: colorGreen, // Color del borde
                        width: 2, // Grosor del borde
                      ),
                      backgroundColor: Colors.white, // Color de fondo del botón
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Alinea el contenido a la izquierda
                      children: [
                        Container(
                          width: 40, // Ajusta el tamaño según sea necesario
                          height:  40, // Ajusta el tamaño según sea necesario
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorGreen, // Color de fondo del círculo
                          ),
                          child: const Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                fontSize: 18, // Ajusta el tamaño del texto
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Color del texto
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Espacio entre el símbolo y el texto
                        const Text(
                          'Añadir\n'
                          'Ejercicio',
                          style:
                              TextStyle(color: Colors.black), // Color del texto
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8), // Añade espacio horizontal
                    decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del contenedor
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: const Color(0xFF34D399), // Color del borde
                        width: 2, // Grosor del borde
                      ),
                    ),
                    alignment: Alignment
                        .center, // Centra el contenido dentro del contenedor
                    child: const Text(
                      '80% de Metas Alcanzadas',
                      textAlign:
                          TextAlign.center, // Centra el texto horizontalmente
                      style: TextStyle(
                        color: Colors.black, // Color del texto
                        fontSize: 16, // Ajusta el tamaño del texto
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8), // Añade espacio horizontal
                    decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del contenedor
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: const Color(0xFF34D399), // Color del borde
                        width: 2, // Grosor del borde
                      ),
                    ),
                    alignment: Alignment
                        .center, // Centra el contenido dentro del contenedor
                    child: const Text(
                      '80% de Metas Alcanzadas',
                      textAlign:
                          TextAlign.center, // Centra el texto horizontalmente
                      style: TextStyle(
                        color: Colors.black, // Color del texto
                        fontSize: 16, // Ajusta el tamaño del texto
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.6, // Altura del botón
                  width: screenWidth *
                      0.4, // Ancho proporcional al tamaño de pantalla
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/meals_list'); // Acción al presionar el botón
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Bordes redondeados
                      ),
                      side: BorderSide(
                        color: colorGreen, // Color del borde
                        width: 2, // Grosor del borde
                      ),
                      backgroundColor: Colors.white, // Color de fondo del botón
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // Alinea el contenido a la izquierda
                      children: [
                        Container(
                          width: 40, // Tamaño del círculo
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorGreen, // Color de fondo del círculo
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.history, // Ícono de historial
                              size: 24, // Tamaño del ícono
                              color: Colors.white, // Color del ícono
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Espacio entre el símbolo y el texto
                        const Text(
                          'Ver\nHistorial', // Texto en dos líneas
                          style: TextStyle(
                            color: Colors.black, // Color del texto
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
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