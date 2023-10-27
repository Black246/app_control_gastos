import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          // Guardamos la información al dar tap al boton guardar
          if (cModel.amount != 0.00 && cModel.link != null) {
            // Validamos que la información no valla vacia
            exProvider.addNewExpense(cModel);
            Fluttertoast.showToast(
              msg: '¡Se agrego un nuevo gasto!',
              backgroundColor: Colors.green,
            );
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.00) {
            Fluttertoast.showToast(
                msg: '¡No olvides agregar un monto!',
                backgroundColor: Colors.red);
          } else {
            Fluttertoast.showToast(
                msg: '¡No olvides seleccionar una categoría!',
                backgroundColor: Colors.red);
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 170.0,
          child: Constants.customButton(Colors.red, Colors.white, 'Guardar'),
        ));
  }
}
