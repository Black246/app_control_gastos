import 'package:expenses_app/pages/balance_page.dart';
import 'package:expenses_app/pages/charts_page.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';
import '../widgets/home_page_wt/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final exProvider = context.read<ExpensesProvider>();
    final currentIndex = uiProvider.bnbIndex;
    final DateTime date = DateTime.now();
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
      exProvider.getExpenseByDate(currentMonth, date.year);
      exProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ChartsPage();
      default:
        return const BalancePage();
    }
  }
}
