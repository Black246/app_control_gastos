// En este archivo agregamos los listados de la informacion que aprarece en la parte inferior de PageCharts

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerDayList extends StatelessWidget {
  const PerDayList({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    List<CombinedModel> perDay = [];
    Map<dynamic, dynamic> perDayMap;

    perDayMap = eList.fold({}, (Map<dynamic, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    perDayMap.forEach((day, exp) {
      perDay.add(CombinedModel(day: day, amount: exp));
    });

    perDay.sort((a, b) => b.day.compareTo(a.day));

    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, i) {
          var item = perDay[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'exp_details', arguments: item.day);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Día'),
                    const Divider(),
                    Text(
                      item.day.toString(),
                      style: const TextStyle(fontSize: 25.0),
                    ),
                    const Divider(),
                    Text(getAmountFormat(item.amount))
                  ],
                ),
              ),
            ),
          );
        }, childCount: perDay.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.0,
          // crossAxisSpacing: 12.0
        ));
  }
}
