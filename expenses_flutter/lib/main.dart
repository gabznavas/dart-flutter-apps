import 'dart:math';

import 'package:expenses_flutter/components/chart.dart';
import 'package:expenses_flutter/components/transaction_form.dart';
import 'package:expenses_flutter/components/transaction_list.dart';
import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    final Duration sevenDaysDuration = Duration(days: 7);
    final DateTime sevenDaysAgo = DateTime.now().subtract(sevenDaysDuration);
    return _transactions.where((transaction) {
      final bool isAfterLastSevenDays = transaction.date.isAfter(sevenDaysAgo);
      return isAfterLastSevenDays;
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newId =
        Random().nextDouble().toString() + _transactions.length.toString();
    final newTransaction = Transaction(
      id: newId,
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.insert(0, newTransaction);
    });
    _closeLastScreen();
  }

  void removeTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere(
        (transaction) => transaction.id == transactionId,
      );
    });
  }

  void _closeLastScreen() {
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = AppBar(
      title: SizedBox(
        width: double.infinity,
        child: Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontSize: 20 * MediaQuery.textScalerOf(context).scale(1),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;
    final availableHeight = screenHeight - statusBarHeight - appBarHeight;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) _renderSwitch(),
            if (_showChart || !isLandscape)
              _renderChart(context, availableHeight),
            if (!_showChart || !isLandscape)
              _renderTransactionList(context, availableHeight),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Row _renderSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_showChart ? "Esconder gráfico" : "Mostrar Gráfico"),
        Switch(value: _showChart, onChanged: onChangeShowChart),
      ],
    );
  }

  Widget _renderChart(BuildContext context, double availableHeight) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      height: isLandscape ? availableHeight * .7 : availableHeight * .25,
      child: Chart(_recentTransactions),
    );
  }

  Widget _renderTransactionList(BuildContext context, double availableHeight) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      height: isLandscape ? availableHeight * .85 : availableHeight * .75,
      child: TransactionList(_transactions, removeTransaction),
    );
  }

  void onChangeShowChart(bool value) {
    setState(() {
      _showChart = value;
    });
  }
}
