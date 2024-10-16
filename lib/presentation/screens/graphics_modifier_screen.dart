import 'package:fittracker/presentation/screens/bar_chart_example.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:fittracker/presentation/entities/exercise.dart'; // Importa la clase Exercise

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
      body: const Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView({super.key});

  @override
  ConsumerState<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {
  final List<Widget> _charts = []; // Lista para almacenar los gráficos
  String _selectedOption = 'Comida'; // Opción seleccionada por defecto
  String _selectedDropdownOption =
      'Proteínas'; // Opción seleccionada en el menú desplegable
  List<String> _dropdownOptions = [
    'Proteínas',
    'Carbohidratos',
    'Calorías'
  ]; // Opciones para el menú desplegable
  String? _selectedExercise; // Para almacenar el ejercicio seleccionado

  // Función para agregar un gráfico basado en la opción seleccionada
  void _addChart() {
    try {
      setState(() {
        _charts.add(
          CollapsibleChartWidget(
            name: '$_selectedDropdownOption para $_selectedOption',
          ),
        );
      });
    } catch (error) {
      print("Error al agregar gráfico: $error");
    }
  }

  // Función para mostrar el diálogo de selección con un menú desplegable
  void _showOptionDialog(BuildContext context) {
    final exerciseList = ref.watch(
        exerciseListProvider); // Obtener la lista de ejercicios desde el provider

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
                  // Radio buttons para seleccionar entre "Comida" y "Ejercicio"
                  RadioListTile<String>(
                    title: const Text('Comida'),
                    value: 'Comida',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedOption = value!;
                        _selectedDropdownOption =
                            'Proteínas'; // Resetear la opción del dropdown
                        _dropdownOptions = [
                          'Proteínas',
                          'Carbohidratos',
                          'Calorías'
                        ]; // Actualizar opciones
                        _selectedExercise =
                            null; // Resetear ejercicio seleccionado
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
                        _selectedDropdownOption =
                            'Series'; // Resetear la opción del dropdown
                        _dropdownOptions = [
                          'Series',
                          'Repeticiones',
                          'Peso'
                        ]; // Actualizar opciones
                        _selectedExercise =
                            null; // Resetear ejercicio seleccionado
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Verificar si hay ejercicios en el provider
                  if (_selectedOption == 'Ejercicio' &&
                      exerciseList.isEmpty) ...[
                    const Text(
                        "No hay ejercicios cargados hasta el momento, agregue ejercicios e intente más tarde."),
                    const SizedBox(height: 10),
                  ] else if (_selectedOption == 'Ejercicio') ...[
                    // Menú desplegable que muestra opciones dependiendo de la selección anterior
                    DropdownButton<String>(
                      value: _selectedDropdownOption,
                      items: _dropdownOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDropdownOption = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Nuevo menú desplegable con nombres de ejercicios
                    DropdownButton<String>(
                      value: _selectedExercise,
                      hint: const Text('Selecciona un ejercicio'),
                      items: exerciseList
                          .map((Exercise exercise) =>
                              exercise.name) // Extrae solo los nombres
                          .toSet() // Convierte a un conjunto para eliminar duplicados
                          .map((String name) => DropdownMenuItem<String>(
                                value: name,
                                child: Text(name),
                              ))
                          .toList(), // Crea una lista de DropdownMenuItem
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedExercise = newValue;
                        });
                      },
                    ),
                  ] else if (_selectedOption == 'Comida') ...[
                    // Menú desplegable que muestra opciones de comida
                    DropdownButton<String>(
                      value: _selectedDropdownOption,
                      items: _dropdownOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDropdownOption = newValue!;
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
                    Navigator.of(context)
                        .pop(); // Cerrar el diálogo sin hacer nada
                  },
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    if (_selectedOption == 'Ejercicio' &&
                        exerciseList.isEmpty) {
                      // No permitir agregar el gráfico si no hay ejercicios
                      Navigator.of(context).pop(); // Cerrar el diálogo
                      return;
                    }
                    _addChart(); // Agregar el gráfico con la selección hecha
                    Navigator.of(context).pop(); // Cerrar el diálogo
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
    return Column(
      children: [
        TextButton(
          onPressed: () {
            _showOptionDialog(
                context); // Mostrar el diálogo al presionar el botón
          },
          child: const Text("Agregar nuevo gráfico"),
        ),
        ..._charts, // Mostrar todos los gráficos añadidos
      ],
    );
  }
}

class CollapsibleChartWidget extends StatefulWidget {
  final String name;

  const CollapsibleChartWidget({super.key, required this.name});

  @override
  State<CollapsibleChartWidget> createState() => _CollapsibleChartWidgetState();
}

class _CollapsibleChartWidgetState extends State<CollapsibleChartWidget> {
  bool _isExpanded = false; // Estado para controlar la expansión del gráfico

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado del gráfico
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name), // Nombre del gráfico
            Row(
              children: [
                FilledButton(onPressed: () {}, child: const Text("Editar")),
                IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {
                    // Acción al presionar el botón de estrella
                  },
                ),
                IconButton(
                  icon: RotatedBox(
                    quarterTurns: _isExpanded ? 1 : 0, // Rotar la flecha
                    child: const Icon(Icons.arrow_right),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded =
                          !_isExpanded; // Cambiar el estado de expansión
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        // Simulación de gráfico
        if (_isExpanded) BarChartSample2()
      ],
    );
  }
}
