// Grafico Circular

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPie extends StatefulWidget {
  const ChartPie({Key? key}) : super(key: key);

  @override
  State<ChartPie> createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  String catName = 'TOTAL';
  String catColor = '#388e3c';
  String catIcon = 'attach_money_outlined';
  double catAmount = 0.0;
  double expTotal = 0.0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().groupItemsList;
    var item = gList[_index];

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<CombinedModel, String>(
              dataSource: gList,
              pointColorMapper: (CombinedModel data, _) => data.color.toColor(),
              xValueMapper: (CombinedModel v, _) => v.category,
              yValueMapper: (CombinedModel v, _) => v.amount,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
              ),
              enableTooltip: true,
              innerRadius: '60%',
              radius: '100%',
              selectionBehavior: SelectionBehavior(
                enable: true,
                selectedBorderColor: Colors.white,
                selectedBorderWidth: 2,
              ),
              onPointTap: (args) {
                setState(() {
                  _index = args.pointIndex!;
                  catIcon = gList[_index].icon;
                  catName = gList[_index].category;
                  catAmount = gList[_index].amount;
                  catColor = gList[_index].color;
                });
              },
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                item.icon.toIcon(),
                color: item.color.toColor(),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                item.category,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                getAmountFormat(item.amount),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
