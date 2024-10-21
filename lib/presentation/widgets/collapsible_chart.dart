import 'package:flutter/material.dart';

class CollapsibleChartWidget extends StatefulWidget {
  final String name;
  final Widget chart;
  final String? variable;
  const CollapsibleChartWidget(
      {super.key,
      required this.name,
      required this.chart,
      required this.variable});

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
            Text("Gráfico de ${widget.variable}"), // Nombre del gráfico
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
        if (_isExpanded)
          Column(
            children: [
              Row(
                children: [
                  widget.name == "Comida"
                      ? Text(
                          widget.variable!,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const Column(
                          children: [
                            Text("Repeticiones",
                                style: TextStyle(color: Colors.green)),
                            Text("Series", style: TextStyle(color: Colors.red)),
                            Text("Peso", style: TextStyle(color: Colors.blue))
                          ],
                        )
                ],
              ),
              SizedBox(height: 300, child: widget.chart),
            ],
          )
      ],
    );
  }
}
