import 'dart:math';

import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatefulWidget {

  final Transaction transaction;
  final Function (String transactionId) onRemove;

  const TransactionItem(this.transaction, this.onRemove, {super.key});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static final colors =[
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color _backgroundColor = colors[0];

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    const String dateBrazilFormat = 'd MMM y';

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${widget.transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(widget.transaction.title, style: theme.textTheme.titleMedium),
        subtitle: Text(
          DateFormat(dateBrazilFormat).format(widget.transaction.date),
          style: theme.textTheme.titleSmall,
        ),
        trailing:
        mediaQuery.size.width > 450
            ? TextButton(
          onPressed: () => widget.onRemove(widget.transaction.id),
          child: Column(
            children: [
              Flexible(
                child: Text(
                  "Excluir",
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
              Icon(Icons.delete, color: theme.colorScheme.error),
            ],
          ),
        )
            : IconButton(
          onPressed: () => widget.onRemove(widget.transaction.id),
          icon: Icon(Icons.delete, color: theme.colorScheme.error),
        ),
      ),
    );
  }
}