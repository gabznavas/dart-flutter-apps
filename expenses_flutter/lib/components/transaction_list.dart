import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String transactionId) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? _renderEmptyList(context)
        : _renderList(context);
  }

  Column _renderEmptyList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Nenhuma Transação cadastrada',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
        ),
      ],
    );
  }

  ListView _renderList(BuildContext context) {
    const String dateBrazilFormat = 'd MMM y';

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
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
            title: Text(
              transaction.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              DateFormat(dateBrazilFormat).format(transaction.date),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: IconButton(
              onPressed: () => onRemove(transaction.id),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        );
      },
    );
  }
}
