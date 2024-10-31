import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'Acerca de';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Vivamus lacinia odio vitae vestibulum. Suspendisse potenti. '
              'Sed auctor turpis et lorem vestibulum, eu dignissim nisl '
              'tincidunt. Donec sit amet mi et metus gravida cursus. '
              'Curabitur sit amet varius nunc. Proin ut pharetra ante.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pellentesque habitant morbi tristique senectus et netus '
              'et malesuada fames ac turpis egestas. Nulla sit amet turpis '
              'mi. Sed faucibus ligula sed metus fermentum, ut condimentum '
              'ante vestibulum. Aliquam erat volutpat. Fusce consequat '
              'massa eu tellus faucibus, nec tincidunt dui euismod.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
