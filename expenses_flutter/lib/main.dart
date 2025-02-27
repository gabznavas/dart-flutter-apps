import 'dart:io';
import 'dart:math';

import 'package:expenses_flutter/components/chart.dart';
import 'package:expenses_flutter/components/transaction_form.dart';
import 'package:expenses_flutter/components/transaction_list.dart';
import 'package:expenses_flutter/fake_data.dart';
import 'package:expenses_flutter/models/transaction.dart';
import 'package:expenses_flutter/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(), theme: theme);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [...fakeTransactions];

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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

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
        if (isLandscape) _renderSwitch(context),
        Platform.isIOS ?
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ) : Container(),
      ],
    );

    final screenHeight = mediaQuery.size.height;
    final statusBarHeight = mediaQuery.padding.top;
    final appBarHeight = appBar.preferredSize.height;
    final availableHeight = screenHeight - statusBarHeight - appBarHeight;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Garante que o layout se ajuste
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center
              ,children: [
              Text("Exibir Gráfico"),
              Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: _showChart, onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
            ],),
            if (_showChart || !isLandscape)
              _renderChart(context, availableHeight),
            if (!_showChart || !isLandscape)
              _renderTransactionList(context, availableHeight),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    );
  }

  IconButton _renderSwitch(BuildContext context) {
    return IconButton(
      onPressed: onChangeShowChart,
      icon: Icon(_showChart ? Icons.list : Icons.show_chart_sharp),
    );
  }

  Widget _renderChart(BuildContext context, double availableHeight) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SizedBox(
      height: isLandscape ? availableHeight * .7 : availableHeight * .25,
      child: Chart(_recentTransactions),
    );
  }

  Widget _renderTransactionList(BuildContext context, double availableHeight) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    return SizedBox(
      height: isLandscape ? availableHeight * 1 : availableHeight * .75,
      child: TransactionList(_transactions, removeTransaction),
    );
  }

  void onChangeShowChart() {
    setState(() {
      _showChart = !_showChart;
    });
  }
}
