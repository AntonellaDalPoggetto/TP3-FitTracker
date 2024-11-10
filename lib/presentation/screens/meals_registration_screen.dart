import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MealsRegistrationScreen extends StatelessWidget {
  static const String name = 'Registro de comida';

  const MealsRegistrationScreen({super.key});

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
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  _BodyView();

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

        _dateTimeController.text =
            combinedDateTime.toString();
      }
    }
  }

  void _validateAndSave(BuildContext context, WidgetRef ref) {    
    if (_mealNameController.text.isEmpty || _proteinController.text.isEmpty ||
        _caloriesController.text.isEmpty || _carbsController.text.isEmpty ||
        _dateTimeController.text.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos.'),
        ),
      );
    } 
    else {      
      final Meal newMeal = Meal(
        name: _mealNameController.text,
        protein: double.parse(_proteinController.text),
        calories: double.parse(_caloriesController.text),
        carbs: double.parse(_carbsController.text),
        dateTime: DateTime.parse(_dateTimeController.text),
      );
      ref.read(mealListProvider.notifier).addMeal(newMeal).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comida agregada con éxito'),
          ),
        );
        context.pop();
      }      
      ).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al agregar la comida'),
          ),
        );
        print("Error al agregar comida: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _mealNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la comida',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _proteinController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese las proteinas (g)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese las calorías (kcal)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _carbsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese los carbohidratos (g)',
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
                        1, 4),
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
      ),
    );
  }
}
