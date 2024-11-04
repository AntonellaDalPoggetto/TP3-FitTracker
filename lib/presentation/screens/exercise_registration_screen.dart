import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExerciseRegistrationScreen extends StatelessWidget {
  static const String name = 'Registra tu ejercicio';

  const ExerciseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends ConsumerWidget {
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  _BodyView();

  void dispose() {
    _exerciseNameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    _dateTimeController.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        _dateTimeController.text =
            combinedDateTime.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: _exerciseNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre del ejercicio',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _setsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Número de series',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _repsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Número de repeticiones',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Peso levantado Kg',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dateTimeController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Seleccione la fecha y hora',
              border: OutlineInputBorder(),
            ),
            onTap: () => _selectDateTime(context),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(
                      1, 4), // Mover sombra "N" px a la derecha y "N" px abajo
                  blurRadius: 4,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _validateAndSave(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34D399),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
              ),
              child: const Text("GUARDAR"),
            ),
          )
        ],
      ),
    );
  }

  void _validateAndSave(BuildContext context, WidgetRef ref) {
    if (_exerciseNameController.text.isEmpty ||
        _setsController.text.isEmpty ||
        _repsController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _dateTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos.'),
        ),
      );
    } else {
      final Exercise newExersice = Exercise(
        name: _exerciseNameController.text,
        sets: int.parse(_setsController.text),
        reps: int.parse(_repsController.text),
        weight: double.parse(_weightController.text),
        dateTime: DateTime.parse(_dateTimeController.text),
      );
      //el siguiente codigo debe reemplazarse con el de abajo cuando se agregue el metodo addExercise al provider
      final currentExercises = ref.read(exerciseListProvider);
      final updatedExercises = [...currentExercises, newExersice];
      updatedExercises.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      ref.read(exerciseListProvider.notifier).state = updatedExercises;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ejercicio agregado con éxito'),
        ),
      );
    }
   }
  // El codigo del agregar ejercicio deberia ser el siguiente
  //     ref.read(exerciseListProvider.notifier).addExercise(newExersice).then((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Ejercicio agregado con éxito'),
  //         ),
  //       );
  //       context.pop();
  //     }      
  //     ).catchError((e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Error al agregar Ejercicio'),
  //         ),
  //       );
  //       print("Error al agregar Ejercicio: $e");
  //     });
  //   }
  // }  
}