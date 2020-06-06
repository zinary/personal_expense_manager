import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class ExpenseItem extends StatefulWidget {
  
  const ExpenseItem({
    Key key,
    @required this.transaction,
    @required this.deleteTxn,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTxn;

  @override
  _ExpenseItemState createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
   Color _bgColor;
  final colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.green 
  ];
  @override
  void initState() {

    _bgColor = colors[Random().nextInt(5)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                '₹' + widget.transaction.amount.toStringAsFixed(0),
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          radius: 30,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
              textColor: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTxn(widget.transaction.id),
                icon: Icon(Icons.delete_sweep, color: Theme.of(context).errorColor,),
                label: const Text('delete'),
              )
            : IconButton(
                icon:  const Icon(Icons.delete_sweep),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTxn(widget.transaction.id),
              ),
      ),
    );
  }
}