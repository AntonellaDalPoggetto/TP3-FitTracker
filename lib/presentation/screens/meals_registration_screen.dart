import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MealsRegistrationScreen extends StatelessWidget {
  static const String name = 'registro de comidas';

  const MealsRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soy el $name'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
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
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  _BodyView({
    super.key,
  });

  void dispose() {
    _mealNameController.dispose();
    _proteinController.dispose();
    _caloriesController.dispose();
    _carbsController.dispose();
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

        _dateTimeController.text = combinedDateTime.toString(); // Ajusta el formato si es necesario
      }
    }
  }

  void _validateAndSave(BuildContext context, WidgetRef ref) {
    // Verificar que todos los campos estén completados
    if (_mealNameController.text.isEmpty ||
        _proteinController.text.isEmpty ||
        _caloriesController.text.isEmpty ||
        _carbsController.text.isEmpty ||
        _dateTimeController.text.isEmpty) {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos.'),
        ),
      );
    } else {
      // Crear el objeto Meal y mostrarlo en consola
      final Meal newMeal = Meal(
        name: _mealNameController.text,
        protein: double.parse(_proteinController.text),
        calories: double.parse(_caloriesController.text),
        carbs: double.parse(_carbsController.text),
        dateTime: DateTime.parse(_dateTimeController.text)
      );
      final currentMeals = ref.read(mealListProvider);
      final updatedMeals = [...currentMeals, newMeal];
      ref.read(mealListProvider.notifier).state = updatedMeals;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comida agregada con éxito'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextField(
          controller: _mealNameController,
          decoration: const InputDecoration(
            labelText: 'Nombre de la comida',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _proteinController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Ingrese las proteinas (g)',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _caloriesController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Ingrese las calorías (kcal)',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _carbsController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Ingrese los carbohidratos (g)',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _dateTimeController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Seleccione la fecha y hora',
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDateTime(context),
        ),
        TextButton(
          onPressed: () => _validateAndSave(context, ref), // Llama al método de validación
          child: const Text("Save"),
        ),
      ],
    );
  }
}
