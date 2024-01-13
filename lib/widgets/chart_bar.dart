import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;

  final double spendingAmount;

  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return  Column(
      children: [
        Container(
            height: constraints.maxHeight*.15,
            child: FittedBox(
                child: Text('\₹${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: .05,
        ),
        Container(
          height: constraints.maxHeight*.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 2220, 220, 1),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.pink.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: constraints.maxHeight*.05),
        Container(
          height: constraints.maxHeight*.15,
          child: FittedBox(child: Text(label))),
      ],
    );
    },);
   
  }
}
