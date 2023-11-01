// En esta pagina configuramos el balance principal ese que aparece en la pagina de inicio

import 'dart:math';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart';
import 'package:expenses_app/widgets/balance_page_wt/back_sheet.dart';
import 'package:expenses_app/widgets/balance_page_wt/custom_fab.dart';
import 'package:expenses_app/widgets/balance_page_wt/front_sheet.dart';
import 'package:expenses_app/widgets/balance_page_wt/month_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final _scrollController = ScrollController();
  double _offset = 0;
  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
    });
    if (kDebugMode) {
      print(_max);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  double get _max => max(90 - _offset * 90, 0.0);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;


    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelector(),
                  Text(
                    getBalance(eList, etList),
                    style: const TextStyle(fontSize: 30.0, color: Color.fromARGB(255, 62, 174, 248)),
                  ),
                  const Text(
                    'Balance',
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Stack(
              children: [
                const BackSheet(),
                Padding(
                  padding: EdgeInsets.only(top: _max),
                  child: const FrontSheet(),
                )
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
