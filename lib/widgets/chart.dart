//importing packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/models/transactions.dart';
import 'package:transaction_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));

        var totalsum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekday.day &&
              recentTransactions[i].date.month == weekday.month &&
              recentTransactions[i].date.year == weekday.year) {
            totalsum += recentTransactions[i].amount;
          }
        }

        print(DateFormat.E().format(weekday));

        print(totalsum);

        return {
          'day': DateFormat.E().format(weekday).substring(0, 1),
          'amount': totalsum
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 05,
      shadowColor: Colors.pink.shade400,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'] as String,
                  data['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
