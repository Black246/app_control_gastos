// Esta es la pagina de graficos

import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_selector.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_switch.dart';
import 'package:expenses_app/widgets/charts_page_wt/per_category_list.dart';
import 'package:expenses_app/widgets/charts_page_wt/per_day_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;
    bool isPerDay = false;

    if (currentChart == 'Gráfico Lineal' ||
        currentChart == 'Gráfico de dispersión') {
      isPerDay = true;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text(currentChart),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChartSelector(),
                    Expanded(
                      // child: ChartLine()
                      // child: ChartPie()
                      child: ChartSwitch(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // padding: const EdgeInsets.only(top: 10.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          (isPerDay) ? const PerDayList() : const PerCategoryList()
        ],
      ),
    );
  }
}
