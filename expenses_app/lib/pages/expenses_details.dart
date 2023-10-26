import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {

  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
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
    //Hacemos el llamado a nuestras listas
    final exProvider = context.watch<ExpensesProvider>();
    final cList = exProvider.allItemsList;
    double totalExp = 0.0;

    //Mapeamos mi cList y por cada elemento que venga de amount lo va a sumar; el valor inicail va a ser 0
    totalExp = cList.map((e) => e.amount).fold(0.0, (a , b) => a + b );

    // Con esta condicion controlamos que nuestro total de ingresos no se valla hacia a la derecha y se pierda
    if (_offset > 0.85) _offset = 0.85;

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
                alignment: Alignment(_offset, 1), // Con esta propiedad desplazamos el total de nuestros gastos hacia la parte superior derecha
                child: Text(getAmoutFormat(totalExp))),
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
                  Theme.of(context).primaryColorDark
                ),
              ),
            ),
          ),

          SliverList(delegate: SliverChildBuilderDelegate(
            (context, i) {
              var item = cList[i];
            return ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    // color: item.color.toColor(),
                    size: 35.0,
                  ),
                  Positioned(
                    top: 14,
                    child: Text(
                    item.day.toString()))
                ],
              ),
              title: Row(
                children: [
                  Text(item.category),
                  const SizedBox(width: 8.0),
                  Icon(item.icon.toIcon(),
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
                    getAmoutFormat(item.amount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                 style: const TextStyle(
                  fontSize: 11.0
                 ), 
                )
                ],
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