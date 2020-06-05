import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spentAmount;
  final String label;
  final double spentPctgOfTotal;
  ChartBar({this.label, this.spentAmount, this.spentPctgOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '₹' + spentAmount.toStringAsFixed(0),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spentPctgOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Container(child: FittedBox(child: Text(label,))),
      ],
    );
  }
}
