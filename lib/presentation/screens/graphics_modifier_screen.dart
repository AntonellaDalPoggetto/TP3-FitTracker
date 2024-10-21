import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fittracker/presentation/widgets/bar_chart_example.dart';
import 'package:fittracker/presentation/widgets/collapsible_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:fittracker/presentation/widgets/collapsible_chart.dart';

// El provider para los gráficos
final chartsProvider = StateProvider<List<CollapsibleChartWidget>>((ref) {
  return [];
});

class GraphicsModifierScreen extends StatelessWidget {
  static const String name = 'modificador de gráficos';

  const GraphicsModifierScreen({super.key});

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
      body: const _BodyView(),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView();

  @override
  ConsumerState<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {
  String _selectedOption = 'Comida';
  String? _selectedFoodValue = "Proteínas";
  String? _selectedExercise;

  final List<String> _comidaOptions = ['Proteínas', 'Carbohidratos', 'Calorías'];

  void _addChart() {
    try {
      String name = _selectedOption;
      String? variable;

      if (_selectedOption == 'Ejercicio' && _selectedExercise != null) {
        variable = _selectedExercise;
      } else {
        variable = _selectedFoodValue;
      }

      // Añadir el gráfico al provider en lugar de a una lista local
      ref.read(chartsProvider.notifier).update((state) {
        return [
          ...state,
          CollapsibleChartWidget(
            name: name,
            variable: variable,
            chart: SimpleBarChart(
              variable: variable,
            ),
          ),
        ];
      });
    } catch (error) {
      print("Error al agregar gráfico: $error");
    }
  }

  void _showOptionDialog(BuildContext context) {
    final exerciseList = ref.watch(exerciseListProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Nuevo Gráfico"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('Comida'),
                    value: 'Comida',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                        _selectedExercise = null;
                        _selectedFoodValue = _comidaOptions.first;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Ejercicio'),
                    value: 'Ejercicio',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                        _selectedFoodValue = null;
                        if (exerciseList.isNotEmpty) {
                          _selectedExercise = exerciseList.first.name;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_selectedOption == 'Comida')
                    DropdownButton<String>(
                      value: _selectedFoodValue,
                      items: _comidaOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFoodValue = newValue!;
                        });
                      },
                    ),
                  if (_selectedOption == 'Ejercicio' &&
                      exerciseList.isEmpty) ...[
                    const Text(
                        "No hay ejercicios cargados hasta el momento, agregue ejercicios e intente más tarde."),
                    const SizedBox(height: 10),
                  ] else if (_selectedOption == 'Ejercicio') ...[
                    DropdownButton<String>(
                      value: _selectedExercise,
                      items: exerciseList
                          .map((Exercise exercise) => exercise.name)
                          .toSet()
                          .map((String name) => DropdownMenuItem<String>(
                                value: name,
                                child: Text(name),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedExercise = newValue!;
                        });
                      },
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    if (!(_selectedOption == 'Ejercicio' &&
                        exerciseList.isEmpty)) {
                      _addChart();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final charts = ref.watch(chartsProvider); // Obtenemos la lista de gráficos desde el provider

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                _showOptionDialog(context);
              },
              child: const Text("Agregar nuevo gráfico"),
            ),
          ),
          Column(
            children: charts, // Mostramos los gráficos almacenados en el provider
          ),
        ],
      ),
    );
  }
}
