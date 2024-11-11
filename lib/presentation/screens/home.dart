import 'package:fittracker/presentation/providers/user_Provider.dart';
import 'package:fittracker/presentation/widgets/charts_carousel.dart';
import 'package:fittracker/utils/profile_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends ConsumerStatefulWidget {
  static const String name = 'Home';

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(),
      ),
      body: _BodyView(),
    );
  }
}

//
class Header extends ConsumerStatefulWidget {
  const Header({super.key});

  @override
  _Header createState() => _Header();
}

class _Header extends ConsumerState<Header> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    int? selectedImageId = user?.idImage;
    String username = user != null ? '${user.username[0].toUpperCase()}${user.username.substring(1)}' : "Usuario";

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(getProfileImageById(selectedImageId)),                  
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, $username!',
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Tus gráficos:",
                    style: TextStyle(
                      fontSize: 24, // Tamaño de fuente aumentado
                      fontWeight: FontWeight.bold, // Negrita
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Espacio entre el texto y el carrusel
                Expanded(child: ChartsCarousel()), // Expande el carrusel
              ],
            ),
          ),
        ),
      ],
    );
  }
}
