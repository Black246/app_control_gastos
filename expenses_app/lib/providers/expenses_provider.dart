// Proveedor de caracteristicas y gastos
import 'dart:convert';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/models/expenses_model.dart';
import 'package:expenses_app/models/features_model.dart';
import 'package:expenses_app/providers/db_expenses.dart';
import 'package:expenses_app/providers/db_features.dart';
import 'package:flutter/widgets.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = []; // Lista de categorias
  List<ExpensesModel> eList = []; // Lista de gastos
  List<CombinedModel> cList = []; // Listas combinadas

  //------------------ Funciones para insertar ----------------------------

  //Expenses
  addNewExpense(CombinedModel cModel) async {
    //Recibimos un combined model y lo transformamos a un Expenses model
    var expenses = ExpensesModel(
        link: cModel.link,
        day: cModel.day,
        month: cModel.month,
        year: cModel.year,
        comment: cModel.comment,
        expense: cModel.amount);
    final id = await DBExpenses.db.addExpense(expenses);
    expenses.id = id; // Agregamos el id automaticamente
    eList.add(expenses);
    notifyListeners();
  }

  //Feature
  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;

    fList.add(newFeature);
    notifyListeners();
  }

  //------------------ Funciones para leer --------------------------------

  //Expenses
  getExpenseByDate(int month, int year) async {
    final response = await DBExpenses.db.getExpenseByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  //Feature
  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  //------------------ Funciones para actualizar --------------------------

  //Expenses
  updateExpense(CombinedModel cModel) async {
    //Recibimos un combined model y lo transformamos a un Expenses model
    var expenses = ExpensesModel(
        id: cModel.id, // Aqui si requerimos el id
        link: cModel.link,
        day: cModel.day,
        month: cModel.month,
        year: cModel.year,
        comment: cModel.comment,
        expense: cModel.amount);
    await DBExpenses.db.addExpense(expenses);
    notifyListeners();
  }

  //Feature
  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
  }

  //------------------ Funciones para eliminar --------------------------

  //Expenses
  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpense(id);
    notifyListeners();
  }

  //----------------- Getters de la lista combinada ---------------------

  List<CombinedModel> get allItemsList {
    List<CombinedModel> cModel =
        []; // Esta lista se crea vacia para evitar que cada vez que entremos a gasto se repitan

    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          cModel.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              id: x.id,
              comment: x.comment,
              amount: x.expense,
              day: x.day,
              month: x.month,
              year: x.year));
        }
      }
    }
    return cList = [...cModel];
  }

  List<CombinedModel> get groupItemsList {
    List<CombinedModel> cModel =
        []; // Esta lista se crea vacia para evitar que cada vez que entremos a gasto se repitan

    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          double amount = eList
              .where((e) => e.link == y.id)
              .fold(0.0, (a, b) => a + b.expense);

          cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            amount: amount,
          ));
        }
      }
    }

    //Con este encode pasamos la lista a Stirng para poder combinarlas
    var encode = cModel.map((e) => jsonEncode(e));
    var unique = encode
        .toSet(); // Con este toSet agrupamos las categorias que vienen iguales
    var result = unique.map((e) => jsonDecode(
        e)); // Con este jsonDecode transformamos la lista de String a Json
    cModel = result
        .map((e) => CombinedModel.fromJson(e))
        .toList(); //Mapeamos todo de nuevo

    return cList = [...cModel];
  }
}
