import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/widgets/add_entries_wt/comments_et_box.dart';
import 'package:expenses_app/widgets/add_entries_wt/date_et_picker.dart';
import 'package:expenses_app/widgets/add_entries_wt/save_et_button.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_number_keyboard.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddEntries extends StatelessWidget {
  const AddEntries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar nuevo ingreso'),
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
                  DateEntriesPicker(cModel: cModel),
                  CommentEntriesBox(cModel: cModel),
                  Expanded(
                      child: Center(
                         child: SaveEntriesButton(cModel: cModel)
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
