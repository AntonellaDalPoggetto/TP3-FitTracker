import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fittracker/presentation/providers/exersice_list_provider.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimpleBarChart extends ConsumerStatefulWidget {
  final String? variable;

  const SimpleBarChart({super.key, required this.variable});

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends ConsumerState<SimpleBarChart> {
  double maxYValue = 70;

  List<BarChartGroupData> generateGraphData(List<dynamic> data) {
    List<BarChartGroupData> graphData = [];
    bool isMealData = data is List<Meal>;
    double maxNumber = 0;
    double numberToShow = 0;

    if (isMealData) {
      List<Meal> meals = data;
      if (meals.length > 7) {
        meals = meals.sublist(meals.length - 7);
      }
      for (var currentMeal in meals) {
        switch (widget.variable) {
          case "Proteínas":
            numberToShow = currentMeal.protein;
            break;
          case "Carbohidratos":
            numberToShow = currentMeal.carbs;
            break;
          case "Calorías":
            numberToShow = currentMeal.calories;
            break;
          default:
            return [];
        }
        maxNumber = maxNumber < numberToShow ? numberToShow : maxNumber;
        graphData.add(
          BarChartGroupData(
            x: currentMeal.dateTime.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(
                toY: numberToShow,
                color: Color(0xFF34D399),
                width: 20,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ],
          ),
        );
      }
    } else {
      List<Exercise> exercises = data as List<Exercise>;
      exercises = exercises.where((ex) => ex.name.toLowerCase() == widget.variable?.toLowerCase()).toList();

      if (exercises.length > 7) {
        exercises = exercises.sublist(exercises.length - 7);
      }
      for (var currentExercise in exercises) {
        double sets = currentExercise.sets.toDouble();
        double weight = currentExercise.weight;
        double reps = currentExercise.reps.toDouble();
        maxNumber = [sets, weight, reps].reduce((a, b) => a > b ? a : b);
        graphData.add(
          BarChartGroupData(
            x: currentExercise.dateTime.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(
                toY: sets,
                color: Colors.deepPurple,
                width: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              BarChartRodData(
                toY: weight,
                color: Color(0xFF34D399),
                width: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              BarChartRodData(
                toY: reps,
                color: Colors.green[900],
                width: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ],
          ),
        );
      }
    }

    if (maxYValue < maxNumber) {
      maxYValue = maxNumber + (maxNumber * 0.05);
    }

    return graphData;
  }

  @override
  Widget build(BuildContext context) {
    final mealData = ref.watch(mealListProvider).reversed.toList();
    final exerciseData = ref.watch(exerciseListProvider).reversed.toList();

    List<dynamic> dataToShow;
    if (["Proteínas", "Carbohidratos", "Calorías"].contains(widget.variable)) {
      dataToShow = mealData;
    } else {
      dataToShow = exerciseData;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: generateGraphData(dataToShow),
            maxY: maxYValue,
            barTouchData: BarTouchData(enabled: true),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
              ),
            ),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: maxYValue / 5, // Espaciado entre los valores del eje Y
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    String formattedString = '${date.day}/${date.month}';
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 10.0,
                      child: Text(
                        formattedString,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
