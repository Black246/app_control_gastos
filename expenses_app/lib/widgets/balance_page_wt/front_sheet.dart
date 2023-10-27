import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/widgets/balance_page_wt/flayer_skin.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flayer_categories.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }

    return Container(
        //height: 800.0,
        decoration: Constants.sheetBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor),
        child: (hasData)
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                    FlayerSkin(
                        myTitle: 'Categoría de gastos',
                        myWidget: FlayerCategories()),
                    FlayerSkin(
                        myTitle: 'Fecuencia con la que gasto',
                        myWidget: SizedBox(height: 150.0)),
                    FlayerSkin(
                        myTitle: 'Mis movimientos',
                        myWidget: SizedBox(height: 150.0)),
                    FlayerSkin(
                        myTitle: 'Balance general',
                        myWidget: SizedBox(height: 150.0)),
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset('assets/No_data.png'),
                  ),
                  const Text(
                    'No tienes gastos este mes, agrega uno aquí 👇',
                    maxLines: 1,
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                  )
                ],
              ));
  }
}
