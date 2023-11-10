// Aqui creamos funciones constantes para utilizar en otros archivos

import 'package:expenses_app/models/entries_model.dart';
import 'package:expenses_app/models/expenses_model.dart';
import 'package:intl/intl.dart';
export 'package:expenses_app/utils/math_operations.dart';

// Con esta funcion le damos formato a los numeros
getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

// Con esta función obtenemos la sumatoria de los gastos para mostrarlos
getSumOfExpenses(List<ExpensesModel> eList) {
  double eLista;

  eLista = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return eLista;
}

// Con esta función obtenemos la sumatoria de los ingresos para mostrarlos
getSumOfEntries(List<EntriesModel> etList) {
  double etLista;

  etLista = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return etLista;
}

//Con esta función obtenemos el balance
getBalance(List<ExpensesModel> eList, List<EntriesModel> etList) {
  double balance;

  balance = getSumOfEntries(etList) - getSumOfExpenses(eList);
  return getAmountFormat(balance);
}
