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
        height: 340.0, // Incrementa la altura del carrusel para dar más espacio al texto
        autoPlay: true,
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
      ),
      items: charts.map((chartWidget) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFF34D399),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alineación superior
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0), // Solo padding horizontal y en la parte superior
                child: SizedBox(
                  height: 270,
                  child: chartWidget.chart,
                ),
              ),// Espacio entre el gráfico y el texto
              Center(child: Text("Tipo de gráfico: ${chartWidget.name}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))), // Texto debajo del gráfico, centrado
              Center(child: Text("Datos mostrados: ${chartWidget.variable!}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))), // Texto debajo del gráfico, centrado
            ],
          ),
        );
      }).toList(),
    );
  }
}
