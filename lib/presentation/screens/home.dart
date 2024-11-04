import 'package:fittracker/presentation/providers/user_Provider.dart';
import 'package:fittracker/presentation/widgets/charts_carousel.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
    String username = user != null ? '${user.username[0].toUpperCase()}${user.username.substring(1)}' : "Usuario"; 

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
        // Usa Expanded para centrar el ChartsCarousel y darle espacio arriba y abajo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0), // Ajusta este valor según sea necesario
            child: ChartsCarousel(),
          ),
        ),
      ],
    );
  }
}
