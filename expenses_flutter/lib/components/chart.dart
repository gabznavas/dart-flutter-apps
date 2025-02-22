import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransaction = [];

  Chart(this.recentTransaction, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    final int daysWeek = 7;
    final today = DateTime.now();

    return List.generate(daysWeek, (index) {
      final Duration subtractDay = Duration(days: index);
      final DateTime weekDay = today.subtract(subtractDay);
      final String weekDayName = DateFormat.E().format(weekDay);
      final String weekDayNameFirstLetter = weekDayName[0];

      double totalSum = 0.0;
      for (Transaction transaction in recentTransaction) {
        final bool sameDay = transaction.date.year == weekDay.year;
        final bool sameMonth = transaction.date.month == weekDay.month;
        final bool sameYear = transaction.date.day == weekDay.day;
        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }

      return {'day': weekDayNameFirstLetter, 'value': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children:
            groupedTransactions.map((item) {
              final key = item.cast()['day'];
              final value = item.cast()['value'];
              return Column(children: [Text(key), Text(value.toString())]);
            }).toList(),
      ),
    );
  }
}
