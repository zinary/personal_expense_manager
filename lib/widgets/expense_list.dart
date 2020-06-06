import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTxn;

  ExpenseList(this._transactions, this.deleteTxn);
  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
                    Image.asset(
                    'assets/empty1.png',
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.6,
                  ),
                    Text(
                    'No Expenses currently',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold)
                 
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return ExpenseItem(transaction: _transactions[index], deleteTxn: deleteTxn);
            },
          );
  }
}

