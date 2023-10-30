// En esta pagina mostramos los detalles de las categorias
import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({super.key});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  Widget build(BuildContext context) {
    var cList = context.watch<ExpensesProvider>().allItemsList;
    var eList = context.watch<ExpensesProvider>().eList;
    var etList = context.watch<ExpensesProvider>().etList;
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    // Creamos esta variable para pasarla al porcentaje de entradas
    var totalEt = getAmoutFormat(
      getSumOfEntries(etList)
    );

    var totalExp = getAmoutFormat(
      getSumOfExpenses(eList)
    );

    cList = cList.where(((e) => e.category == cModel!.category)).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            title: Text(
              cModel!.category,
              style: TextStyle(
                color: cModel.color.toColor()
              )
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    getAmoutFormat(cModel.amount),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: cModel.color.toColor()
                    ),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PercentCircular(
                          percent: cModel.amount / getSumOfEntries(etList), 
                          radius: 70, 
                          color: Colors.green,
                          arcType: ArcType.HALF,
                          ),
                        Text(
                          'Absorbe de tus Ingresos:\n$totalEt',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PercentCircular(
                          percent: cModel.amount / getSumOfExpenses(eList), 
                          radius: 70, 
                          color: Colors.red,
                          arcType: ArcType.HALF,
                          ),
                        Text(
                          'Representa de tus Gastos:\n$totalExp',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark
                ),
              ),
            ),
          ),

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, i) {
              var item = cList[i];
              return  ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 35.0),
                    Positioned(
                      top: 13,
                      child: Text(item.day.toString()),
                    )
                  ],
                ),
                title: PercentLinear(
                  percent: item.amount / cModel.amount, // Dividimos la cantidad de nuestra categoria "item.amount" por la cantidad total "cModel.amount"
                  color: item.color.toColor(),
                ),
                trailing: Text(
                  getAmoutFormat(item.amount),
                  style: const TextStyle(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            childCount: cList.length
          ))
        ],
      ),
    );
  }
}