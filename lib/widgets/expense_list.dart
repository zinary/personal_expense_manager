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
                    height: constraints.maxHeight * 0.5,
                  ),
                  const SizedBox(height: 10,),
                    Text(
                    'No Expenses currently',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold)
                 
                  ),
                ],
              );
            },
          )
        : ListView(
            physics: BouncingScrollPhysics(),
         
              children: [
                ..._transactions.map((txn) {
                  return  ExpenseItem(key: ValueKey(txn.id),transaction:txn, deleteTxn: deleteTxn,);
                }).toList()
                 
              ] 
           
          );
  }
}

