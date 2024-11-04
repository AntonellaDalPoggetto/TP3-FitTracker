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
                          style: const TextStyle(color: Color(0xFF34D399)),
                        )
                      : Row(
                          children: [
                            Text("Repeticiones",
                                style: TextStyle(color: Colors.green[900])),
                            SizedBox(width: 20),
                            const Text("Series", style: TextStyle(color: Colors.deepPurple)),
                            SizedBox(width: 20),
                            const Text("Peso", style: TextStyle(color: Color(0xFF34D399)))
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
