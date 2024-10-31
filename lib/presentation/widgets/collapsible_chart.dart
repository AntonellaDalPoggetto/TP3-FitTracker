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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Gráfico de ${widget.variable}"),
            Row(
              children: [
                FilledButton(onPressed: () {}, child: const Text("Editar")),
                IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {
                  },
                ),
                IconButton(
                  icon: RotatedBox(
                    quarterTurns: _isExpanded ? 1 : 0,
                    child: const Icon(Icons.arrow_right),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded =
                          !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
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
