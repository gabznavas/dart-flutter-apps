import 'dart:math';

import 'package:expenses_flutter/components/transaction_form.dart';
import 'package:expenses_flutter/components/transaction_list.dart';
import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'Sorvete', value: 10, date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'Conta #1',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta #2',
      value: 211.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta #3',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Conta #4',
      value: 211.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Conta #5',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Conta #6',
      value: 211.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Conta #5',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Conta #6',
      value: 211.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Conta #5',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Conta #6',
      value: 211.22,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }

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
      _transactions.add(newTransaction);
    });
  }
}
