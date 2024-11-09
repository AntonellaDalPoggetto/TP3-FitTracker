import 'package:fittracker/presentation/entities/chart.dart';
import 'package:fittracker/presentation/providers/chart_provider.dart';
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
      final Chart newChart = Chart(
        name: _selectedOption,
        variable: _selectedValue, 
        dateTime: DateTime.now()
      );

       ref.read(chartListProvider.notifier)
           .addChart(newChart)
           .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gráfico agregado con éxito')),
            );   
      });  
    } catch (error) {
      print("Error al agregar gráfico: $error");
    }
  }

  void _showOptionDialog(BuildContext context) {
    final exerciseList = ref.watch(exerciseListProvider);
    List<String> exerciseNameList = exerciseList
        .map((exercise) => exercise.name.trim().toLowerCase())
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
                  if (_selectedOption == "Ejercicio" &&
                      exerciseNameList.isEmpty)
                    Text(
                        "Todavía no hay ejercicios agregados, agrega uno nuevo para crear gráficos de ejercicios")
                  else
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              height: 52,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: OutlinedButton(
                onPressed: () {
                  _showOptionDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: const Color(0xFF34D399), width: 1),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.black.withOpacity(0.7),
                  elevation: 4,
                ),
                child: Text(
                  'Agregar nuevo gráfico',
                  style: TextStyle(
                    color: const Color(0xFF34D399),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Lista de gráficos
            if (charts.isEmpty)
              const Center(child: Text("No hay gráficos agregados"))
            else
              Column(
                children: charts,
              ),
          ],
        ),
      ),
    );
  }
}
