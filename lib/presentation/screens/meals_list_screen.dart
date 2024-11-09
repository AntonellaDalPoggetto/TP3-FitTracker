import 'package:fittracker/presentation/widgets/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fittracker/presentation/providers/meal_list_provider.dart';
import 'package:fittracker/presentation/entities/meal.dart';

class MealsListScreen extends StatelessWidget {
  static const String name = 'listado de comidas';

  const MealsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial de Comidas',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: _BodyView(),
      ),
    );
  }
}

class _BodyView extends ConsumerStatefulWidget {
  const _BodyView();

  @override
  _BodyViewState createState() => _BodyViewState();
}

class _BodyViewState extends ConsumerState<_BodyView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealList = ref.watch(mealListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tus comidas: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nombre comida',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              ref.read(mealListProvider.notifier).filterByName(value);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: mealList.length,
              itemBuilder: (context, index) {
                final meal = mealList[index];
                return MealCard(meal: meal);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MealCard extends ConsumerWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: const Icon(Icons.fastfood, size: 40),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(meal.name),
            Text("Proteínas: ${meal.protein}g"),
          ],
        ),
        subtitle: Text(
            '${meal.dateTime.day.toString()}/${meal.dateTime.month.toString()}/${meal.dateTime.year.toString()}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Proteínas: ${meal.protein}g"),
                    Text("Carbohidratos: ${meal.carbs}g"),
                    Text("Calorías: ${meal.calories}kcal"),
                    Text("Consumido el: ${meal.dateTime.day.toString()}/${meal.dateTime.month.toString()}/${meal.dateTime.year.toString()} a las ${meal.dateTime.hour.toString()}:${meal.dateTime.minute.toString()}"),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDeleteDialog(
                          title: 'Confirmar eliminación',
                          content:
                              '¿Estás seguro de que deseas eliminar esta comida?',
                          onConfirm: () {
                            ref.read(mealListProvider.notifier).deleteMeal(meal.mealID!);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
