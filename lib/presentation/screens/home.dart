import 'package:fittracker/presentation/providers/chart_provider.dart';
import 'package:fittracker/presentation/widgets/home_graph.dart';
import 'package:fittracker/presentation/widgets/button_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class Home extends ConsumerStatefulWidget  {
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
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight *0.25,
                    child: ref.watch(chartsProvider)[0].chart,
                  ),
                  SizedBox(
                  width: screenWidth * 0.4,
                    height: screenHeight *0.25,
                    child: ref.watch(chartsProvider)[1].chart,
                  ),
                ],
              ),
              SizedBox(
               width: screenWidth * 0.4,
                    height: screenHeight *0.5,
                child: ref.watch(chartsProvider)[2].chart,
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
                    child: ref.watch(chartsProvider)[0].chart,
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

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ButtonInfo('Agregar Comida','/meals_registration'),
      ButtonInfo('Agregar Ejercicio', '/exercise_registration'),
    ]),
  ];
}

Row _buildButtonRow(double height, double width, Color colorGreen, BuildContext context, List<ButtonInfo> buttonLabels) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: buttonLabels.map((label) {
      return _buildSingleButton(height, width, colorGreen, label, context);
    }).toList(),
  );
}

SizedBox _buildSingleButton(double height, double width, Color colorGreen, ButtonInfo buttonInfo, BuildContext context) {
  return SizedBox(
    height: height,
    width: width,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        ElevatedButton(
          onPressed: () {
            context.push(buttonInfo.screen);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 8),
              Text(
                buttonInfo.name,
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
                  context.push(buttonInfo.screen);
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
    _buildHistoryButtonRow(screenHeight, screenWidth, colorGreen, context),
  ];
}
Row _buildHistoryButtonRow(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
            _buildProgressContainer(screenHeight, screenWidth),
            _buildHistoryButton(screenHeight, screenWidth, colorGreen, context),
    ],
  );
}

SizedBox _buildHistoryButton(double screenHeight, double screenWidth, Color colorGreen, BuildContext context) {
  return SizedBox(
    height: screenHeight * 0.6,
    width: screenWidth * 0.4,
    child: ElevatedButton(
      onPressed: () {
        context.push('/exercises_list'); // Cambia la ruta según sea necesario
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
          const Icon(Icons.history, color: Colors.black),
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