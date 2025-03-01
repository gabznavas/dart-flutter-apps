import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleSmall: TextStyle(fontSize: 14, fontFamily: 'RobotoCondensed'),
          titleMedium: TextStyle(fontSize: 17, fontFamily: 'RobotoCondensed'),
          titleLarge: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
        ),
      ),
      home: CategoryScreen(),
    );
  }
}
