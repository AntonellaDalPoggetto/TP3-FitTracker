import 'package:carousel_slider/carousel_slider.dart';
import 'package:fittracker/presentation/providers/chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartsCarousel extends ConsumerWidget {
  const ChartsCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charts = ref.watch(chartsProvider);

    if (charts.isEmpty) {
      return const Center(
        child: Text('No hay gráficos disponibles'),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
      ),
      items: charts.map((chartWidget) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Color(0xFF34D399),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300, 
              child: chartWidget.chart,
            ),
          ),
        );
      }).toList(),
    );
  }
}
