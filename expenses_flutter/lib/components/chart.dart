import 'package:expenses_flutter/components/chart_bar.dart';
import 'package:expenses_flutter/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransaction = [];

  Chart(this.recentTransaction, {super.key});

  // TODO: Criar uma classe em vez de usar map
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

  double sumValues() {
    return recentTransaction
        .map((item) => item.value)
        .reduce((tot, value) => tot + value);
  }

  @override
  Widget build(BuildContext context) {
    final totalValues = sumValues();

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            groupedTransactions.map((item) {
              final name = item.cast()['day'];
              final value =
                  double.tryParse(item.cast()['value'].toString()) ?? 0.0;
              final double percent =
                  value == 0 ? 0.0 : (value / totalValues) * 100;
              return ChartBar(name, value, percent);
            }).toList(),
      ),
    );
  }
}
