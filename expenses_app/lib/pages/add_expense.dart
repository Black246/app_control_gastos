import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_category.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_number_keyboard.dart';
import 'package:expenses_app/widgets/add_expenses_wt/comments_box.dart';
import 'package:expenses_app/widgets/add_expenses_wt/date_picker.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
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
                          child: GestureDetector(
                              onTap: () {
                                print(cModel.amount);
                              },
                              child: const Text('Botón Guardar')))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
