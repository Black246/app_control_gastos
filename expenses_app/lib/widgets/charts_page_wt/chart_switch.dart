import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_line.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_pie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitch extends StatelessWidget {
  const ChartSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;

    switch(currentChart){
      case 'Gráfico Lineal' : return const ChartLine();
      case 'Gráfico Circular' : return const ChartPie();
      default: return const ChartLine();
    }
  }
}