import 'package:expenses_app/widgets/add_expenses_wt/bs_number_keyboard.dart';
import 'package:flutter/material.dart';

import '../utils/constans.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const BSNumberKeyboard(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Fecha 12/12/12'),
                  Text('Seleccionar Categoria'),
                  Text('Agregar Descripción'),
                  Expanded(child: Center(child: Text('Botón Guardar')))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
