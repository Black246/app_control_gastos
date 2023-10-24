
// import 'package:expenses_app/models/features_model.dart';
// import 'package:expenses_app/providers/db_features.dart';
// import 'package:flutter/widgets.dart';

// class ExpensesProvider extends ChangeNotifier{
//   List<FeaturesModel> fList = [];

//   addNewFeature(FeaturesModel newFeature) async {
//     // final newFeature = FeaturesModel(
//     //   category: category,
//     //   color: color,
//     //   icon: icon
//     // );

//     final id = await DBFeatures.db.addNewFeature(newFeature);
//     newFeature.id = id;

//     fList.add(newFeature);
//     notifyListeners();
//   }

//   getAllFeatures() async {
//     final response = await DBFeatures.db.getAllFeatures();
//     fList = [...response];
//     notifyListeners();
//   }

//   updateFeatures(FeaturesModel features) async{
//     await DBFeatures.db.updateFeatures(features);
//     notifyListeners();
//   }
// }