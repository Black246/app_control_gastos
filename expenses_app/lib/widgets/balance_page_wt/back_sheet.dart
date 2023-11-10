// En este archivo mostramos la sumatoria de los gastos e ingresos que aparecen en el inicio

import 'package:expenses_app/pages/entries_details.dart';
import 'package:expenses_app/pages/expenses_details.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    headers(String name, String amount, Color color) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 13.0, bottom: 5.0),
              child: Text(name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.5,
                  ))),
          Text(amount,
              style:
                  TextStyle(fontSize: 20.0, letterSpacing: 1.5, color: color))
        ],
      );
    }

    return Container(
      height: 250.0,
      decoration:
          Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
               PagesAnimationRoutes(
                widget: const EntriesDetails(), 
                ejex: -0.5, 
                ejey: -0.5
                )
              );
            },
            child: headers(
              'Ingresos',
              getAmountFormat(getSumOfEntries(etList)), // Le damos formato y recibimos la sumatoria de los ingresos
              Colors.green
            )),
          const VerticalDivider(
            thickness: 2.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PagesAnimationRoutes(
                  widget: const ExpensesDetails(),  
                  ejex: 0.5, 
                  ejey: -0.5
                )
              );
            },
            child: headers(
              'Gastos', 
              getAmountFormat(getSumOfExpenses(eList)), // Le damos formato y recibimos la sumatoria de los gastos
              Colors.red
          )),
        ],
      ),
    );
  }
}
