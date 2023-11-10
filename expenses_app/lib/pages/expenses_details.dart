// En esta pagina mostramos los detalles de los gastos

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  List<CombinedModel> cList = [];

  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      // Con esta condicion controlamos que nuestro total de gastos no se valla hacia a la derecha y se pierda
      if (_offset > 0.85) _offset = 0.85;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    cList = context.read<ExpensesProvider>().allItemsList;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hacemos el llamado a nuestras listas
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?; // Aqui recibimos los argumento de PerDayList que es el dia, para mostrar los gastos realizados ese dia
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    cList = context.watch<ExpensesProvider>().allItemsList;

    double totalExp = 0.0;

    if (dataDay != null){
      cList = cList.where((e) => e.day == dataDay).toList();
    }

    // Mapeamos mi cList y por cada elemento nuevo que venga de amount se suma; el valor inicail va a ser 0
    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);

    cList.sort((a, b) => b.day.compareTo(a.day));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollController, // Llamamos al controlador de Scroll
        slivers: [
          SliverAppBar(
            expandedHeight: 125.0,
            title: const Text('Tus gastos'),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset,
                      1), // Con esta propiedad desplazamos el total de nuestros gastos hacia la parte superior derecha
                  child: Text(getAmountFormat(totalExp),
                    style: const TextStyle(color: Colors.red),
                  )),
              centerTitle: true,
              background: const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 30.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
            var item = cList[i];
            return Slidable(
              key: ValueKey(item),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      setState(() {
                        cList.removeAt(i);
                      });
                      exProvider.deleteExpense(item.id!);
                      uiProvider.bnbIndex =
                          0; // Lo mandamos a la opcion 0 de home_page que es BalancePage para que refresque y se noten los cambios
                      showToastWidget(
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '¡Gasto eliminado con exito!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Borrar',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.pushNamed(context, 'add_expenses',
                          arguments: item);
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  )
                ],
              ),
              child: ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      // color: item.color.toColor(),
                      size: 35.0,
                    ),
                    Positioned(top: 14, child: Text(item.day.toString()))
                  ],
                ),
                title: Row(
                  children: [
                    Text(item.category),
                    const SizedBox(width: 8.0),
                    Icon(
                      item.icon.toIcon(),
                      color: item.color.toColor(),
                    )
                  ],
                ),
                subtitle: Text(item.comment),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getAmountFormat(item.amount),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 11.0),
                    )
                  ],
                ),
              ),
            );
          }, childCount: cList.length))
        ],
      ),
    );
  }
}
