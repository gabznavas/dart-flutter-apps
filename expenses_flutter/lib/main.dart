import 'dart:math';

import 'package:expenses_flutter/components/transaction_form.dart';
import 'package:expenses_flutter/components/transaction_list.dart';
import 'package:expenses_flutter/fake_data.dart';
import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [...fakeTransactionsData];

  void _addTransaction(String title, double value) {
    final newId =
        Random().nextDouble().toString() + _transactions.length.toString();
    final newTransaction = Transaction(
      id: newId,
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.insert(0, newTransaction);
    });
    _cancelTransaction();
  }

  void _cancelTransaction() {
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction, _cancelTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: double.infinity,
          child: Text('Despesas Pessoais!', textAlign: TextAlign.center),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
