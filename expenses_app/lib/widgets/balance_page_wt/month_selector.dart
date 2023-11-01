// En este archivo creamos el selector de mes que aparece en la parte superior

import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.read<UIProvider>();
    int currentPage = context.watch<UIProvider>().selectedMonth;
    PageController controller;

    controller =
        PageController(initialPage: currentPage, viewportFraction: 0.4);

    return SizedBox(
      height: 45.0,
      child: PageView(
        onPageChanged: (int i) => uiProvider.selectedMonth = i,
        controller: controller,
        children: [
          pageItmes('Enero', 0, currentPage),
          pageItmes('Febrero', 1, currentPage),
          pageItmes('Marzo', 2, currentPage),
          pageItmes('Abril', 3, currentPage),
          pageItmes('Mayo', 4, currentPage),
          pageItmes('Junio', 5, currentPage),
          pageItmes('Julio', 6, currentPage),
          pageItmes('Agosto', 7, currentPage),
          pageItmes('Septiembre', 8, currentPage),
          pageItmes('Octubre', 9, currentPage),
          pageItmes('Noviembre', 10, currentPage),
          pageItmes('Diciembre', 11, currentPage),
        ],
      ),
    );
  }

  pageItmes(String name, int position, int currentPage) {
    var alignment = Alignment.center;

    // Le damos estos estilos al texto cuando esta seleccionado
    const selected = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);

    // Le damos estos estilos cuando el texto no esta seleccionado
    final unSelected = TextStyle(fontSize: 18.0, color: Colors.grey[700]);

    if (position == currentPage) {
      alignment = Alignment.center;
    } else if (position > currentPage) {
      alignment = Alignment.centerRight / 2;
    } else {
      alignment = Alignment.centerLeft / 2;
    }

    return Align(
      alignment: alignment,
      child: Text(
        name,
        style: position == currentPage
            ? selected
            : unSelected, // Con esta condicion escojemos los estilos
      ),
    );
  }
}
