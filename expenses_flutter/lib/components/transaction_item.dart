import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatelessWidget {

  final Transaction transaction;
  final Function (String transactionId) onRemove;

  const TransactionItem(this.transaction, this.onRemove, {super.key});

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
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(transaction.title, style: theme.textTheme.titleMedium),
        subtitle: Text(
          DateFormat(dateBrazilFormat).format(transaction.date),
          style: theme.textTheme.titleSmall,
        ),
        trailing:
        mediaQuery.size.width > 450
            ? TextButton(
          onPressed: () => onRemove(transaction.id),
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
          onPressed: () => onRemove(transaction.id),
          icon: Icon(Icons.delete, color: theme.colorScheme.error),
        ),
      ),
    );
  }
}