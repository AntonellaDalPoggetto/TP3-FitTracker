import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Graph extends ConsumerWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Meal> meals = ref.watch(mealListProvider);
    
    List<BarChartGroupData> barGroups = meals.asMap().entries.map((entry) {
      int index = entry.key;
      Meal meal = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: meal.protein,
            color: Colors.amber,
            width: 8,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();

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
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final int index = value.toInt();
                    if (index < 0 || index >= meals.length) return const Text('');

                    final String date = meals[index].dateTime.toString();
                    if (shownDates.contains(date)) return const Text('');

                    shownDates.add(date);
                    return Text(date);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}