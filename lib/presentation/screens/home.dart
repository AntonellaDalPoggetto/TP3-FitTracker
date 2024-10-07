import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  static const String name = 'Home';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soy el $name'),
      ),
      body: const Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(
          onPressed: () {
            context.go('/meals_registration');
          },
          child: const Text("Agregar comida")),
      TextButton(
          onPressed: () {
            context.go('/exercise_registration');
          },
          child: const Text("Agregar Ejercicio")),
      TextButton(
          onPressed: () {
            context.go('/graphics_modifier');
          },
          child: const Text("Mis gráficos")),
      const Text("Calorías x día"),
      const _Graph()
    ]);
  }
}

class _Graph extends ConsumerWidget {
  const _Graph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> meals = ref.watch(mealListProvider);

    // Crear datos para el gráfico de barras
    List<BarChartGroupData> barGroups = meals.asMap().entries.map((entry) {
      int index = entry.key;
      Meal meal = entry.value;
      return BarChartGroupData(
        x: index, // Usamos el índice como el eje X
        barRods: [
          BarChartRodData(
            toY: meal.protein, // Mostrar las calorías consumidas
            color: Colors.amber,
            width: 8, // Más delgado
            borderRadius: BorderRadius.zero, // Sin puntas curvadas
          )
        ],
      );
    }).toList();

    // Crear un conjunto para rastrear las fechas ya mostradas
    final shownDates = <String>{};

    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 && value.toInt() < meals.length) {
                      DateTime dateTime = meals[value.toInt()].dateTime;
                      String formattedDate =
                          '${dateTime.day}/${dateTime.month}';
                      String formattedHour =
                          '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';

                      // Si la fecha ya fue mostrada, mostrar también la hora
                      if (!shownDates.add(formattedDate)) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            '$formattedDate\n$formattedHour',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          formattedDate,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    return Container(); // Si no hay una fecha, no mostrar nada
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: const FlGridData(
                show: true, drawVerticalLine: false, drawHorizontalLine: true),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
