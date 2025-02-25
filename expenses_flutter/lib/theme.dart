import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: false,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
  ),
  fontFamily: 'Quicksand',
  textTheme: ThemeData.light().textTheme.copyWith(
    titleSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 19,
      fontWeight: FontWeight.w700,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber,
    primary: Colors.purple,
    secondary: Colors.amber.shade600,
  ),
);
