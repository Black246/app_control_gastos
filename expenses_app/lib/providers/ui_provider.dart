import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _bnbIndex = 0;
  int _slectedMonth = DateTime.now().month - 1;

  int get bnbIndex => _bnbIndex;

  set bnbIndex(int i) {
    _bnbIndex = i;
    notifyListeners();
  }

  int get selectedMonth => _slectedMonth;
  set selectedMonth(int i) {
    _slectedMonth = i;
    notifyListeners();
  }
}
