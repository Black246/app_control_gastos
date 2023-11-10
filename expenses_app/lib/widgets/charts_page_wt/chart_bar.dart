// Grafico de Barras

import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumOfExpenses(eList);
    totalEt = getSumOfEntries(etList);

    final ingresosData = [ChartData('INGS', totalEt, Colors.green)];
    final gastosData = [ChartData('GTOS', totalExp, Colors.red)];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
        primaryXAxis:
            CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: 
            NumericAxis(
            axisLine: const AxisLine(color: Colors.transparent),
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
            numberFormat: NumberFormat.compact(),
            labelStyle: const TextStyle(color: Colors.transparent)
            ),
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: ingresosData,
              spacing: 2.5,
              xValueMapper: (ChartData sales, _) => sales.name,
              yValueMapper: (ChartData sales, _) => sales.amount,
              pointColorMapper: (ChartData sales, _) => sales.color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          ColumnSeries<ChartData, String>(
              dataSource: gastosData,
              spacing: 2.5,
              xValueMapper: (ChartData sales, _) => sales.name,
              yValueMapper: (ChartData sales, _) => sales.amount,
              pointColorMapper: (ChartData sales, _) => sales.color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)))
        ]);
  }
}

class ChartData {
  final String name;
  final double amount;
  final Color color;

  ChartData(this.name, this.amount, this.color);
}
