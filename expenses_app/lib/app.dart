import 'package:expenses_app/pages/add_expense.dart';
import 'package:expenses_app/pages/categories_details.dart';
import 'package:expenses_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale("en"), Locale("es")],
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green[800], foregroundColor: Colors.white),
        colorScheme: const ColorScheme.dark(primary: Colors.red),
        dividerColor: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'add_expenses': (_) => const AddExpenses(),
        'cat_details': (_) => const CategoriesDetails(),
      },
    );
  }
}
