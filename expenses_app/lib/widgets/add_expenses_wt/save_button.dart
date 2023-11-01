// En este archivo creamos el boton para guardar o editar un gasto

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButton({super.key, required this.cModel, required this.hasData});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          // Guardamos la información al dar tap al boton guardar
          if (cModel.amount != 0.00 && cModel.link != null) {
            // Validamos que la información no valla vacia
            (hasData)
                ? exProvider.updateExpense(
                    cModel) // Si hasData trae información la actualizamos
                : exProvider.addNewExpense(cModel); // De lo contrario guardamos

            showToastWidget(
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    (hasData)
                        ? '¡Gasto editado con exito!'
                        : '¡Se agrego un nuevo gasto!',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 16.0)),
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '¡No olvides agregar un monto!',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              duration: const Duration(seconds: 2),
            );
          } else {
            showToastWidget(
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('¡No olvides seleccionar una categoria!',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                duration: const Duration(seconds: 2));
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 170.0,
          child: Constants.customButton(
              Colors.red, Colors.transparent, (hasData) ? 'Editar' : 'Guardar'),
        ));
  }
}
