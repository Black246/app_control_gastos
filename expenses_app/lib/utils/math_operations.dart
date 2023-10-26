import 'package:intl/intl.dart';
export 'package:expenses_app/utils/math_operations.dart';

getAmoutFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}