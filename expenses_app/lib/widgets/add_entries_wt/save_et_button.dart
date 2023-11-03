// En este archivo creamos el boton para guardar o editar un ingreso

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class SaveEntriesButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveEntriesButton({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          // Guardamos la información al dar tap al boton guardar
          if (cModel.amount != 0.00) {
            // Validamos que la información no valla vacia
            exProvider.addNewEntries(cModel);

            showToastWidget(
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('¡Se agrego un nuevo ingreso!',
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
              duration: const Duration(seconds: 2),
            );
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.00) {
            showToastWidget(
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('¡No olvides agregar un ingreso!',
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),
                duration: const Duration(seconds: 2));
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 170.0,
          child: Constants.customButton(
              Colors.green, Colors.transparent, 'Guardar'),
        ));
  }
}
