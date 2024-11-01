import 'package:fittracker/presentation/providers/chart_provider.dart';
import 'package:fittracker/presentation/widgets/collapsible_chart.dart';
import 'package:fittracker/presentation/widgets/home_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends ConsumerStatefulWidget {
  static const String name = 'Home';


  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    _BodyView(),
    Text('Comidas'),
    Text('Ejercicio'),
    Text('Estadísticas'),
    Text('Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double minHeight = screenHeight * 0.60;
    double maxHeight = screenHeight * 0.88;
    List<CollapsibleChartWidget> charts = ref.watch(chartsProvider);

    return Scaffold(
      appBar: AppBar(
        title: _Header(),
      ),
      body: SlidingUpPanel(
        panel: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tus Gráficos Favoritos:",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Desliza hacia abajo para ver cerrar",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.35,
                    child: charts.length > 0
                        ? charts[0].chart
                        : Graph(screenWidth * 0.45),
                  ),
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.35,
                    child: charts.length > 1
                        ? charts[1].chart
                        : Graph(screenWidth * 0.45),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
                child: charts.length > 2
                    ? charts[2].chart
                    : Graph(screenWidth * 0.9),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tus Gráficos Favoritos:",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Desliza hacia arriba para ver más",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.35,
                    child: charts.length > 0
                        ? charts[0].chart
                        : Graph(screenWidth * 0.4),
                  ),
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.35,
                    child: charts.length > 1
                        ? charts[1].chart
                        : Graph(screenWidth * 0.4),
                  ),
                ],
              ),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
                child: charts.length > 2
                    ? charts[2].chart
                    : Graph(screenWidth * 0.8),
              ),
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

class _Header extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola,Usuario!',
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: screenHeight * 0.085,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OutlinedButton(
            onPressed: () {
              context.push('/meals_registration');
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colorGreen, width: 1),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black.withOpacity(0.7),
              elevation: 4,
            ),
            child: Text(
              'Añadir Comida',
              style: GoogleFonts.rubik(
                color: Color(0xFF34D399),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Container(
          height: screenHeight * 0.085,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OutlinedButton(
            onPressed: () {
              context.push('/exercise_registration');
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colorGreen, width: 1),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black.withOpacity(0.7),
              elevation: 4,
            ),
            child: Text(
              'Añadir Ejercicio',
              style: GoogleFonts.rubik(
                color: Color(0xFF34D399),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}