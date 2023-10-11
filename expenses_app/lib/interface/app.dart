import 'package:expenses_app/interface/pages/add_expense.dart';
import 'package:expenses_app/interface/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green[800], foregroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColorDark: Colors.grey[850],
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'addEntries': (_) => const AddExpenses()
      },
    );
  }
}
