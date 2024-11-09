import 'package:fittracker/presentation/widgets/bar_chart_example.dart';
import 'package:flutter/material.dart';

class CollapsibleChartWidget extends StatefulWidget {
  final String name;
  final SimpleBarChart chart;
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: const Icon(Icons.bar_chart, size: 40),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Gráfico de ${widget.variable}"),
          ],
        ),
        subtitle: Text("Nombre del gráfico: ${widget.name}"),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.name == "Comida"
                    ? Row(
                        children: [
                          IconButton(
                              icon:
                                  Icon(Icons.square, color: Color(0xFF34D399)),
                              onPressed: null),
                          Text(
                            widget.variable!,
                            style: const TextStyle(color: Color(0xFF34D399)),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  icon:
                                      Icon(Icons.square, color: Colors.deepPurple),
                                  onPressed: null),
                              const Text("Series",
                                  style: TextStyle(color: Colors.deepPurple)),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              IconButton(
                                  icon:
                                      Icon(Icons.square, color: Color(0xFF34D399)),
                                  onPressed: null),
                              const Text("Peso",
                                  style: TextStyle(color: Color(0xFF34D399))),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              IconButton(
                                  icon:
                                      Icon(Icons.square, color: Colors.green[900]),
                                  onPressed: null),
                              Text("Repeticiones",
                                  style: TextStyle(color: Colors.green[900])),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                SizedBox(height: 300, child: widget.chart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
