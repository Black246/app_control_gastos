// En esta pagina es donde creamos un gasto (La parte visual)

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_category.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_number_keyboard.dart';
import 'package:expenses_app/widgets/add_expenses_wt/comments_box.dart';
import 'package:expenses_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:expenses_app/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?; // Madamos los argumetos para que la información llegue cargada

    // Si la información no esta vacia enviamos la información que estaba cargada
    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Scaffold(
      appBar: AppBar(
        // Si hasData trae información de gasto se cambia el titulo de lo contrario queda igual "Agregar gasto"
        title: (hasData) ? const Text('Editar gasto') : const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(
            cModel: cModel,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel),
                  BSCategory(cModel: cModel),
                  CommentBox(cModel: cModel),
                  Expanded(
                      child: Center(
                         child: SaveButton(
                          cModel: cModel,
                          hasData: hasData,
                      )
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
