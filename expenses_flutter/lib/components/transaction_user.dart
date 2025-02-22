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
      title: 'Tenis novo',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de luz',
      value: 211.22,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TransactionList(_transactions), TransactionForm()],
    );
  }
}
