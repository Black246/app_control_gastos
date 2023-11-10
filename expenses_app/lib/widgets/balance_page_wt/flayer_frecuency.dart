// Este flayer es el que muestra el grafico lineal en la pagina de inicio

import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.read<UIProvider>();

    return Column(
      children: [
        const SizedBox(
          height: 180.0,
          child: ChartLine(),
        ),
        GestureDetector(
          onTap: () {
            uiProvider.bnbIndex = 1;
            uiProvider.selectedChart = 'Gráfico Lineal';
          },
          child: const Align(
            alignment: Alignment.bottomRight,
            widthFactor: 4.5,
            child: Text(
              'DETALLES',
              style: TextStyle(fontSize: 12.0, letterSpacing: 1.5),
            ),
          ),
        )
      ],
    );
  }
}
