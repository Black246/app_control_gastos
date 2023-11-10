// Grafico de Linea

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expenses_app/models/expenses_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';

class ChartLine extends StatefulWidget {
  const ChartLine({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChartLineState createState() => _ChartLineState();
}

class _ChartLineState extends State<ChartLine> {
  late TooltipBehavior _tooltipBehavior;

  String getAmountFormat(double amount) {
    return NumberFormat.simpleCurrency().format(amount);
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150, maxHeight: 100),
            padding: const EdgeInsets.all(
                10), // Añade un padding alrededor del texto
            decoration: BoxDecoration(
              color: Colors.grey[900], // Cambia el color de fondo a negro
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: Colors.blue,
                  width:
                      1), // Añade un borde alrededor del tooltip // Añade bordes redondeados al tooltip
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Día: ${point.x}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight
                          .bold), // Cambia el color del texto a blanco y lo pone en negrita
                  textAlign: TextAlign.center, // Centra el texto
                ),
                const Divider(color: Colors.white), // Añade una línea divisoria
                Text(
                  'Gasto: ${getAmountFormat(point.y)}',
                  style: const TextStyle(
                      color:
                          Colors.white), // Cambia el color del texto a blanco
                ),
              ],
            ),
          );
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var eList = context.watch<ExpensesProvider>().eList;
    var currentMonth = context.watch<UIProvider>().selectedMonth + 1;
    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;

    mapExp = eList.fold({}, (Map<int, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    mapExp.forEach((key, value) {
      eModel.add(ExpensesModel(day: key, expense: value));
    });

    eModel.add(ExpensesModel(day: 0, expense: 0.0));
    eModel.sort((a, b) => a.day.compareTo(b.day));

    var lastDayOfMonth =
        DateTime(DateTime.now().year, currentMonth + 1, 0).day.toDouble();

    return SizedBox(
      child: SfCartesianChart(
          trackballBehavior: TrackballBehavior(enable: true),
          primaryYAxis: NumericAxis(numberFormat: NumberFormat.compact()),
          primaryXAxis: NumericAxis(maximum: lastDayOfMonth, interval: 5),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<ExpensesModel, num>(
              dataSource: eModel,
              xValueMapper: (ExpensesModel expense, _) => expense.day,
              yValueMapper: (ExpensesModel expense, _) => expense.expense,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              markerSettings: const MarkerSettings(isVisible: true),
            )
          ]),
    );
  }
}
