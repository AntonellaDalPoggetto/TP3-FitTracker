import 'package:fittracker/core/router/app_router.dart';
import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fittracker/presentation/providers/spot_list_provider.dart';
import 'package:fittracker/presentation/screens/meals_list_screen.dart';
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
      const _InsertData(),
      const Text("Calorías x día"),
      const _Graph()
    ]);
  }
}

class _InsertData extends ConsumerWidget {
  const _InsertData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double count = 0;
    return TextButton(
        onPressed: () {
          count++;
          final currentSpots = ref.read(spotListProvider);
          final updatedSpots = [...currentSpots, FlSpot(count, count)];
          ref.read(spotListProvider.notifier).state = updatedSpots;
        },
        child: const Text("Nuevo punto"));
  }
}

class _Graph extends ConsumerWidget {
  const _Graph();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> meals = ref.watch(mealListProvider);
    List<FlSpot> spots = meals.map((meal) {
      return FlSpot(
          meal.dateTime.millisecondsSinceEpoch.toDouble(), meal.protein);
    }).toList();

    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                  spots: spots,
                  color: Colors.amber,
                  barWidth: 3,
                  isCurved: true,
                  curveSmoothness: 1,
                  dotData: const FlDotData(
                    show: false,
                  )
              ),
            ],
            titlesData: const FlTitlesData(
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false))),
          ),
        ),
      ),
    );
  }
}
