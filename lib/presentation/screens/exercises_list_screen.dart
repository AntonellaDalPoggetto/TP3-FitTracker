import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:fittracker/presentation/widgets/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/entities/exercise.dart';

class ExercisesListScreen extends StatelessWidget {
  static const String name = 'listado de ejercicios';

  const ExercisesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de ejercicios',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView();

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
    final List<Exercise> exerciseList = ref.watch(exerciseListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
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

class ExerciseCard extends ConsumerWidget {
  final Exercise exercise; // Recibe un objeto Exercise

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: Icon(Icons.directions_run, size: 40),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(exercise.name), 
            Text("${exercise.sets}x${exercise.reps} Reps")
          ],
        ),
        subtitle: Text(
            '${exercise.dateTime.day.toString()}/${exercise.dateTime.month.toString()}/${exercise.dateTime.year.toString()}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Series: ${exercise.sets}'),
                Text('Repeticiones: ${exercise.reps}'),
                Text('Peso levantado: ${exercise.weight}Kg'),
                Text("Realizado el ${exercise.dateTime.day.toString()}/${exercise.dateTime.month.toString()}/${exercise.dateTime.year} a las ${exercise.dateTime.hour.toString()}:${exercise.dateTime.minute.toString()}"),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDeleteDialog(
                          title: 'Confirmar eliminación',
                          content:
                              '¿Estás seguro de que deseas eliminar esta comida?',
                          onConfirm: () {
                            ref
                                .read(exerciseListProvider.notifier)
                                .deleteExercise(exercise.exerciseID!);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ), // Muestra la fecha del ejercicio
          ),
        ],
      ),
    );
  }
}
