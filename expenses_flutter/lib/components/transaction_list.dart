import 'package:expenses_flutter/components/transaction_item.dart';
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
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
        return TransactionItem(transaction, onRemove);
      },
    );
  }
}

