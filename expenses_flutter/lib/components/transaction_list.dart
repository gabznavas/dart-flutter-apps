import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String transactionId) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');
    return transactions.isEmpty
        ? _renderEmptyList(context)
        : _renderList(context);
  }

  LayoutBuilder _renderEmptyList(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constrains) {
        final double titleHeight = constrains.maxHeight * 0.10;
        final double imageHeight = constrains.maxHeight * 0.75;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: titleHeight,
              child: Text(
                'Nenhuma Transação cadastrada',
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: imageHeight,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    );
  }

  ListView _renderList(BuildContext context) {
    const String dateBrazilFormat = 'd MMM y';

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);

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
      },
    );
  }
}
