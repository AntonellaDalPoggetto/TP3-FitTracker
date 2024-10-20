import 'package:fittracker/presentation/entities/exercise.dart';
import 'package:fittracker/presentation/entities/meal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<dynamic> data;
  final String? variable;

  const SimpleBarChart({super.key, required this.data, required this.variable});

  List<BarChartGroupData> generateGraphData() {
    List<BarChartGroupData> graphData = [];
    bool expression = data is List<Meal>;

    if (expression) {
      // si es una lista de comidas
      data.map((meal) {
        Meal currentMeal = meal as Meal;
        double numberToShow = 0;
        switch (variable) {
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
            return 0;
        }
        graphData.add(BarChartGroupData(x: 1, barRods: [
          BarChartRodData(toY: numberToShow, color: Colors.red, width: 15)
        ]));
      }).toList();
    } else {
      // es una lista de ejercicios
      data.map((exercise) {
        Exercise currentExercise = exercise as Exercise;
        if (currentExercise.name == variable) {
          graphData.add(BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: currentExercise.sets.toDouble(), color: Colors.red, width: 3),
            BarChartRodData(toY: currentExercise.weight, color: Colors.blue, width: 3),
            BarChartRodData(toY: currentExercise.reps.toDouble(), color: Colors.green, width: 3)
          ]));
        }
      }).toList();
    }

    return graphData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100, // Valor máximo en el eje Y
              barTouchData: BarTouchData(
                  enabled: false), // Interacción con las barras desactivada
              borderData:
                  FlBorderData(show: false), // Elimina los bordes del gráfico
              barGroups: generateGraphData()),
        ),
      ),
    );
  }
}
