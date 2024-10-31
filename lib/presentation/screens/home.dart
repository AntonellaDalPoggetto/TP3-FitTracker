import 'package:fittracker/presentation/widgets/home_graph.dart';
import 'package:fittracker/presentation/widgets/button_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static const String name = 'Home';

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    child: Graph(screenWidth * 0.45),
                  ),
                  SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.35,
                    child: Graph(screenWidth * 0.45),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
                child: Graph(screenWidth * 0.9),
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
            // mainAxisAlignment: MainAxisAlignment.start,
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
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.25,
                    child: Graph(screenWidth * 0.4),
                  ),
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.25,
                    child: Graph(screenWidth * 0.4),
                  ),
                ],
              ),
              SizedBox(
                width: screenWidth * 0.8,
                height: minHeight * 0.4,
                child: Graph(screenWidth * 0.8),
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
                // fontFamily: 'Roboto',
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

// }

// class _BodyView extends StatelessWidget {
//   const _BodyView();

//   @override
//   Widget build(BuildContext context) {
//     Color colorGreen = const Color(0xFF34D399);
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Column(
//       children: [
//         // LayoutBuilder(
//         //   builder: (context, constraints) {
//         //     double carouselHeight = screenHeight * 0.2;
//         //     double buttonHeight = carouselHeight * 0.7;
//         //     double buttonWidth = carouselHeight * 0.6;

//         //     return CarouselSlider(
//         //       options: CarouselOptions(
//         //         height: carouselHeight,
//         //         autoPlay: false,
//         //         enlargeCenterPage: true,
//         //         viewportFraction: 0.9,
//         //         enableInfiniteScroll: false,
//         //       ),
//         //       items: _buildCarouselItems(
//         //           buttonHeight, buttonWidth, colorGreen, context),
//         //     );
//         //   },
//         // ),
//         // Botón para Agregar Comida
//         Container(
//           width: double.infinity, // Hacer el botón largo
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: ElevatedButton(
//             onPressed: () {
//               //               context.push(/meals_registration);
//             },
//             child: const Text('Agregar Comida'),
//             style: ElevatedButton.styleFrom(
//               // color: colorGreen, // Usar color verde
//               padding: const EdgeInsets.symmetric(vertical: 16), // Aumentar el padding vertical
//             ),
//           ),
//         ),
//         // Botón para Agregar Ejercicio
//         Container(
//           width: double.infinity, // Hacer el botón largo
//           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: ElevatedButton(
//             onPressed: () {
//               context.push('/exercise_registration');
//             },
//             child: const Text('Agregar Ejercicio'),
//             style: ElevatedButton.styleFrom(
//               // primary: colorGreen, // Usar color verde
//               padding: const EdgeInsets.symmetric(vertical: 16), // Aumentar el padding vertical
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class _BodyView extends StatelessWidget {
// //   const _BodyView();

// //   @override
// //   Widget build(BuildContext context) {
// //     Color colorGreen = const Color(0xFF34D399);
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double screenHeight = MediaQuery.of(context).size.height;

// //     return Column(
// //       children: [
// //         // LayoutBuilder(
// //         //   builder: (context, constraints) {
// //         //     double carouselHeight = screenHeight * 0.2;
// //         //     double buttonHeight = carouselHeight * 0.7;
// //         //     double buttonWidth = carouselHeight * 0.6;

// //         //     return CarouselSlider(
// //         //       options: CarouselOptions(
// //         //         height: carouselHeight,
// //         //         autoPlay: false,
// //         //         enlargeCenterPage: true,
// //         //         viewportFraction: 0.9,
// //         //         enableInfiniteScroll: false,
// //         //       ),
// //         //       items: _buildCarouselItems(
// //         //           buttonHeight, buttonWidth, colorGreen, context),
// //         //     );
// //         //   },
// //         // ),
// //         // Botón para Agregar Comida
// //         Container(
// //           width: double.infinity, // Hacer el botón largo
// //           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //           child: ElevatedButton(
// //             onPressed: () {
// //               // Acción para agregar comida
// //             },
// //             child: const Text('Agregar Comida'),
// //             style: ElevatedButton.styleFrom(
// //               // color: colorGreen, // Usar color verde
// //               padding: const EdgeInsets.symmetric(vertical: 16), // Aumentar el padding vertical
// //             ),
// //           ),
// //         ),
// //         // Botón para Agregar Ejercicio
// //         Container(
// //           width: double.infinity, // Hacer el botón largo
// //           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //           child: ElevatedButton(
// //             onPressed: () {
// //               // Acción para agregar ejercicio
// //             },
// //             child: const Text('Agregar Ejercicio'),
// //             style: ElevatedButton.styleFrom(
// //               // primary: colorGreen, // Usar color verde
// //               padding: const EdgeInsets.symmetric(vertical: 16), // Aumentar el padding vertical
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }



// //   List<Widget> _buildCarouselItems(double buttonHeight, double buttonWidth,
// //       Color colorGreen, BuildContext context) {
// //     return [
// //       _buildButtonRow(buttonHeight, buttonWidth, colorGreen, context, [
// //         ButtonInfo('Agregar Comida', '/meals_registration'),
// //         ButtonInfo('Agregar Ejercicio', '/exercise_registration'),
// //       ]),
// //     ];
// //   }

// //   Row _buildButtonRow(double height, double width, Color colorGreen,
// //       BuildContext context, List<ButtonInfo> buttonLabels) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //       children: buttonLabels.map((label) {
// //         return _buildSingleButton(height, width, colorGreen, label, context);
// //       }).toList(),
// //     );
// //   }

// //   SizedBox _buildSingleButton(double height, double width, Color colorGreen,
// //       ButtonInfo buttonInfo, BuildContext context) {
// //     return SizedBox(
// //       height: height,
// //       width: width,
// //       child: Stack(
// //         alignment: Alignment.topCenter,
// //         children: [
// //           ElevatedButton(
// //             onPressed: () {
// //               context.push(buttonInfo.screen);
// //             },
// //             style: ElevatedButton.styleFrom(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               side: BorderSide(
// //                 color: colorGreen,
// //                 width: 2,
// //               ),
// //               backgroundColor: Colors.white,
// //             ),
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 SizedBox(height: 8),
// //                 Text(
// //                   buttonInfo.name,
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             top: height * 0.1,
// //             child: Container(
// //               width: height * 0.5,
// //               height: height * 0.5,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: colorGreen,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.2),
// //                     offset: Offset(0, 2),
// //                     blurRadius: 4,
// //                   ),
// //                 ],
// //               ),
// //               child: Center(
// //                 child: InkWell(
// //                   onTap: () {
// //                     context.push(buttonInfo.screen);
// //                   },
// //                   child: const Text(
// //                     '+',
// //                     style: TextStyle(
// //                       fontSize: 34,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildCircularIcon(Color colorGreen, BuildContext context,
// //       dynamic content, VoidCallback onTap) {
// //     return Container(
// //       width: 40,
// //       height: 40,
// //       decoration: BoxDecoration(
// //         shape: BoxShape.circle,
// //         color: colorGreen,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.2),
// //             offset: Offset(0, 2),
// //             blurRadius: 4,
// //           ),
// //         ],
// //       ),
// //       child: Center(
// //         child: InkWell(
// //           onTap: onTap,
// //           child: content is String
// //               ? Text(
// //                   content,
// //                   style: TextStyle(
// //                     fontSize: 24,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 )
// //               : Icon(
// //                   content,
// //                   size: 24,
// //                   color: Colors.white,
// //                 ),
// //         ),
// //       ),
// //     );
// //   }

// //   // List<Widget> _buildSecondaryCarousel(double screenHeight, double screenWidth,
// //   //     Color colorGreen, BuildContext context) {
// //   //   return [
// //   //     _buildHistoryButtonRow(screenHeight, screenWidth, colorGreen, context),
// //   //   ];
// //   // }

// //   // Row _buildHistoryButtonRow(double screenHeight, double screenWidth,
// //   //     Color colorGreen, BuildContext context) {
// //   //   return Row(
// //   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //   //     children: [
// //   //       _buildProgressContainer(screenHeight, screenWidth),
// //   //       _buildHistoryButton(screenHeight, screenWidth, colorGreen, context),
// //   //     ],
// //   //   );
// //   // }

// // //   SizedBox _buildHistoryButton(double screenHeight, double screenWidth,
// // //       Color colorGreen, BuildContext context) {
// // //     return SizedBox(
// // //       height: screenHeight * 0.6,
// // //       width: screenWidth * 0.4,
// // //       child: ElevatedButton(
// // //         onPressed: () {
// // //           context.push('/exercises_list'); // Cambia la ruta según sea necesario
// // //         },
// // //         style: ElevatedButton.styleFrom(
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(20),
// // //           ),
// // //           side: BorderSide(
// // //             color: colorGreen,
// // //             width: 2,
// // //           ),
// // //           backgroundColor: Colors.white,
// // //         ),
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.start,
// // //           children: [
// // //             const Icon(Icons.history, color: Colors.black),
// // //             const SizedBox(width: 8),
// // //             const Text(
// // //               'Ver\nHistorial',
// // //               style: TextStyle(color: Colors.black),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   SizedBox _buildProgressContainer(double screenHeight, double screenWidth) {
// // //     return SizedBox(
// // //       height: screenHeight * 0.4,
// // //       width: screenWidth * 0.4,
// // //       child: Container(
// // //         padding: const EdgeInsets.symmetric(horizontal: 8),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(30.0),
// // //           border: Border.all(
// // //             color: const Color(0xFF34D399),
// // //             width: 2,
// // //           ),
// // //         ),
// // //         alignment: Alignment.center,
// // //         child: const Text(
// // //           '80% de Metas Alcanzadas',
// // //           textAlign: TextAlign.center,
// // //           style: TextStyle(
// // //             color: Colors.black,
// // //             fontSize: 16,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // }