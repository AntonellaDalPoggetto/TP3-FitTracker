import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittracker/presentation/entities/chart.dart';
import 'package:fittracker/presentation/providers/auth_provider.dart';
import 'package:fittracker/presentation/widgets/bar_chart_example.dart';
import 'package:fittracker/presentation/widgets/collapsible_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<List<CollapsibleChartWidget>> chartsProvider =
    StateProvider<List<CollapsibleChartWidget>>((ref) {
  return [];
});

class ChartListNotifier extends StateNotifier<List<Chart>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;
  final Ref ref;

  ChartListNotifier(this.ref, this._authService) : super([]);

  Future<void> deleteChart(String chartID) async {
    try {
      await _firestore.collection('Chart').doc(chartID).delete();
      state = state.where((m) => m.chartID != chartID).toList();
      _sortChartsByDate();
    } catch (e) {
      print('Error al eliminar el Grafico: $e');
    }
  }

  Future<void> addChart(Chart chart) async {
    final currentUser = _authService.currentUser;
    final doc = _firestore.collection('Chart').doc();

    if (currentUser != null) {
      chart.userID = currentUser.uid;
    }
    try {
      chart.chartID = doc.id;
      await doc.set(chart.toFirestore());
      state = [...state, chart];

      ref.read(chartsProvider.notifier).update((state) {
        return [
          ...state,
          CollapsibleChartWidget(
            name: chart.name,
            variable: chart.variable,
            chart: SimpleBarChart(
              variable: chart.variable,
            ),
          ),
        ];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllCharts() async {
    final currentUser = _authService.currentUser;

    final docs = _firestore
        .collection('Chart')
        .where('userID', isEqualTo: currentUser?.uid)
        .withConverter(
          fromFirestore: Chart.fromFirestore,
          toFirestore: (Chart chart, _) => chart.toFirestore(),
        );

    final chartsSnapshot = await docs.get();
    final charts = chartsSnapshot.docs.map((d) => d.data()).toList();
    state = charts;

    final collapsibleWidgets = charts
        .map((chart) => CollapsibleChartWidget(
              name: chart.name,
              variable: chart.variable,
              chart: SimpleBarChart(variable: chart.variable),
            ))
        .toList();

    ref.read(chartsProvider.notifier).update((state) => collapsibleWidgets);

    _sortChartsByDate();
  }

  void _sortChartsByDate() {
    state = [...state]..sort((a, b) {
        if (b.dateTime == null && a.dateTime == null) return 0;
        if (b.dateTime == null) return -1;
        if (a.dateTime == null) return 1;
        return b.dateTime!.compareTo(a.dateTime!);
      });
  }

  void clearState() {
    state = [];
  }
}

final chartListProvider =
    StateNotifierProvider<ChartListNotifier, List<Chart>>((ref) {
  final authService = ref.read(authProvider);
  final notifier = ChartListNotifier(ref, authService);
  notifier.getAllCharts();
  return notifier;
});
