import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fittracker/presentation/entities/exercise.dart';

class ExercisesListScreen extends StatelessWidget {
  static const String name = 'listado de ejercicios';

  const ExercisesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de ejercicios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: const Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView({super.key});

  @override
  _BodyViewState createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    // Puedes inicializar el controlador con un valor si lo deseas
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exerciseList = ref.watch(exerciseListProvider);

     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tus ejercicios: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Nombre ejercicio',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Actualizamos la lista de ejercicios filtrada cada vez que cambia el texto
            ref.read(exerciseListProvider.notifier).filterByName(value);
          },
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              // Creamos una tarjeta por cada ejercicio
              final exercise = exerciseList[index];
              return ExerciseCard(exercise: exercise);
            },
          ),
        ),
      ],
    ),
     );
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise; // Recibe un objeto Exercise

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: Icon(Icons.directions_run, size: 40),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(exercise.name), // Muestra el nombre del ejercicio
            Text("${exercise.sets} series de ${exercise.reps} reps"), // Muestra sets y reps
          ],
        ),
        subtitle: Text('Peso: ${exercise.weight} kg'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Realizado el ${exercise.dateTime.toLocal()}'), // Muestra la fecha del ejercicio
          ),
        ],
      ),
    );
  }
}