import 'package:fittracker/presentation/widgets/collapsible_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


StateProvider<List<CollapsibleChartWidget>> chartsProvider = StateProvider<List<CollapsibleChartWidget>>((ref){
  return [];
});