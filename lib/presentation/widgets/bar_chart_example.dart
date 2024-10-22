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
    bool expression = data is List<Meal>;
    double maxNumber = 0;
    double numberToShow = 0;

    if (expression) {
      List<Meal> meals = data;
      if (meals.length > 7) {
        meals = meals.sublist(meals.length - 7);
      }
      meals.map((currentMeal) {
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
            return;
        }
        if (numberToShow > maxNumber) {
          maxNumber = numberToShow;
        }
        graphData.add(BarChartGroupData(x: currentMeal.dateTime.millisecondsSinceEpoch, barRods: [
          BarChartRodData(toY: numberToShow, color: Colors.red, width: 5)
        ]));
      }).toList();
    } else {
      List<Exercise> exercises = data as List<Exercise>;
      exercises = exercises.where((ex) => ex.name == widget.variable).toList();
      if (exercises.length > 7) {
        exercises = exercises.sublist(exercises.length - 7);
      }
      exercises.map((currentExercise) {
        maxNumber = currentExercise.reps.toDouble();
        if (maxNumber < currentExercise.sets) {
          maxNumber = currentExercise.sets.toDouble();
        } else if (maxNumber < currentExercise.weight) {
          maxNumber = currentExercise.weight;
        }
        graphData.add(BarChartGroupData(
            x: currentExercise.dateTime.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(toY: currentExercise.sets.toDouble(), color: Colors.red, width: 5),
              BarChartRodData(toY: currentExercise.weight, color: Colors.blue, width: 5),
              BarChartRodData(toY: currentExercise.reps.toDouble(), color: Colors.green, width: 5)
            ]));
      }).toList();
    }

    switch (widget.variable) {
      case "Proteínas":
        maxYValue = 25;
        break;
      case "Carbohidratos":
        maxYValue = 100;
        break;
      case "Calorías":
        maxYValue = 840;
        break;
      default:
        maxYValue = 70;
    }

    if (maxYValue < maxNumber) {
      maxYValue = maxNumber + (maxNumber * 0.05);
    }

    return graphData;
  }

  @override
  Widget build(BuildContext context) {
    // Accediendo a los providers para meals y exercises
    final mealData = ref.watch(mealListProvider);
    final exerciseData = ref.watch(exerciseListProvider);

    // Determina si los datos corresponden a Meal o Exercise según la variable
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
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      String formattedString = '${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 10.0,
                        angle: 45,
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
              )),
        ),
      ),
    );
  }
}
