import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class ExpenseItem extends StatelessWidget {
  
  const ExpenseItem({
    Key key,
    @required this.transaction,
    @required this.deleteTxn,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTxn;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                '₹' + transaction.amount.toStringAsFixed(0),
                // style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          radius: 30,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
              textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transaction.id),
                icon: Icon(Icons.delete_sweep, color: Theme.of(context).errorColor,),
                label: const Text('delete'),
              )
            : IconButton(
                icon:  const Icon(Icons.delete_sweep),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transaction.id),
              ),
      ),
    );
  }
}