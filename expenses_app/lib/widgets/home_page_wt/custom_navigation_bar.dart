import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final watchIndex = context.watch<UIProvider>();
    final read = context.read<UIProvider>();
    return BottomNavigationBar(
      currentIndex: uiProvider.bnbIndex,
      onTap: (int i) => uiProvider.bnbIndex = i,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
            label: 'Balance', icon: Icon(Icons.account_balance_outlined)),
        BottomNavigationBarItem(
            label: 'Gráficos', icon: Icon(Icons.bar_chart_outlined)),
        BottomNavigationBarItem(
            label: 'Configuración', icon: Icon(Icons.settings)),
      ],
    );
  }
}
