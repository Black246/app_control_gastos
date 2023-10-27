import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlayerCategories extends StatelessWidget {
  const FlayerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final gList = exProvider.groupItemsList;
    List<CombinedModel> limitList = [];
    bool hasLimit = false;

    // Con esta condicion limitamos mostrar todas las categorias 
    if(gList.length >= 6) {
      limitList = gList.sublist(0, 5); // Solo mostramos 5
      hasLimit = true;
    }

    if(limitList.length == 5){
      limitList.add(CombinedModel(
        category: 'Más...',
        icon: 'add_circle_outline',
        color: '#edf5ef'
      ));
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (hasLimit) ? limitList.length : gList.length,
            itemBuilder: (_, i){
              var item = gList[i];
              if (hasLimit == true) item = limitList[i];

              return ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -2),
                horizontalTitleGap: -8,
                leading: Icon(
                  item.icon.toIcon(),
                  color: item.color.toColor(),
                ),
                title: Text(
                  item.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Pone 3 puntos cuando el texto es muy largo
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                // trailing: Text(
                //   getAmoutFormat(item.amount)
                // ),
              );
            },
          ),
        )
      ],
    );
  }
}