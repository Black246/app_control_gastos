// En esta pagina mostramos los detalles de los ingresos

import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({super.key});

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
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
    //Hacemps el llamado a nuestras listas
    final etList = context.watch<ExpensesProvider>().etList;
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    double totalEntr = 0.0;

    //Mapeamos a etList y por cada elemento nuevo que venga de entries se suma; el valor inicial es 0.0
    totalEntr = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);

    // Con esta condición controlamos que nuestro total de ingreso na se valla hacia la derecha y se pierda
    if (_offset > 0.85) _offset = 0.85;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
          controller: _scrollController, // Llamamos al controlador de Scroll
          slivers: [
            SliverAppBar(
              expandedHeight: 125.0,
              title: const Text('Tus ingresos'),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Align(
                  alignment: Alignment(_offset,
                      1), // Con esta propiedad desplazamos el total de nuestros gastos hacia la parte superior derecha
                  child: Text(
                    getAmoutFormat(totalEntr),
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
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
              var item = etList[i];
              return Slidable(
                key: ValueKey(item),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          etList.removeAt(i);
                        });
                        exProvider.deleteEntries(item.id!);
                        uiProvider.bnbIndex =
                            0; // Lo mandamos a la opcion 0 de home_page que es BalancePage para que refresque y se noten los cambios
                        showToastWidget(
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              '¡Ingreso eliminado con exito!',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
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
                    // SlidableAction(
                    //   onPressed: (context) {
                    //     Navigator.pushNamed(context, 'add_entries',
                    //         arguments: item);
                    //   },
                    //   backgroundColor: Colors.green,
                    //   foregroundColor: Colors.white,
                    //   icon: Icons.edit,
                    //   label: 'Editar',
                    // )
                  ],
                ),
                child: ListTile(
                  leading: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 35.0,
                      ),
                      Positioned(top: 14, child: Text(item.day.toString()))
                    ],
                  ),
                  title: Row(
                    children: [
                      Text(getAmoutFormat(item.entries)),
                      const SizedBox(width: 8.0)
                    ],
                  ),
                  subtitle: Text(item.comment),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${(100 * item.entries / totalEntr).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: etList.length))
          ]),
    );
  }
}
