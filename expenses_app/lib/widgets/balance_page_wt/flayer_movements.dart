// Este es el flayer de mis movimientos que aparece en la pagina principal

import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovements extends StatelessWidget {
  const FlayerMovements({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;

    totalExp = getSumOfExpenses(eList);
    totalEt = getSumOfEntries(etList);

    return SizedBox(
      height: 200.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: PercentCircular(
              percent: totalExp / totalEt,
              radius: 70.0,
              color: Colors.green,
              arcType: ArcType.FULL,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gastos Realizados',
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.3
                    ),
                  ),
                  Text(
                    getAmountFormat(totalExp),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.3,
                      color: Colors.red
                    ),
                  ),
                  Text(
                    'Absorbe un ${(totalExp / totalEt * 100).toStringAsFixed(2)}% de tus ingresos',
                    style: const TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 1.3
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}