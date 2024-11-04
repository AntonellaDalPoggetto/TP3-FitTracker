import 'package:fittracker/presentation/providers/chart_provider.dart';
import 'package:fittracker/presentation/widgets/bar_chart_example.dart';
import 'package:fittracker/presentation/widgets/collapsible_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';

class GraphicsModifierScreen extends StatelessWidget {
  static const String name = 'modificador de gráficos';

  const GraphicsModifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Estadísticas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
  String _selectedValue = '';

  final List<String> _comidaOptions = [
    'Proteínas',
    'Carbohidratos',
    'Calorías'
  ];

  void _addChart() {
    try {
      String name = _selectedOption;
      String? variable;
      variable = _selectedValue;
      //arriba borre los if porque unifice el selected value

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
    List<String> exerciseNameList = exerciseList
        .map((exercise) {
          return exercise.name;
        })
        .toSet()
        .toList();
    List<String> optionsList =
        _selectedOption == 'Comida' ? _comidaOptions : exerciseNameList;
    _selectedValue = optionsList.first;

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
                        optionsList = _comidaOptions;
                        if (optionsList.isNotEmpty) {
                          _selectedValue = optionsList.first;
                        }
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
                        optionsList = exerciseNameList;
                        if (optionsList.isNotEmpty) {
                          _selectedValue = optionsList.first;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedValue,
                    items: optionsList.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                      });
                    },
                  )
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
    final charts = ref.watch(chartsProvider);

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
            children: charts,
          ),
        ],
      ),
    );
  }
}
