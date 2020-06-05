import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                  Text(
                    'No Expenses currently',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/empty1.png',
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.6,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Text(
                          '₹' + _transactions[index].amount.toStringAsFixed(0),
                          // style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    radius: 30,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                        textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTxn(_transactions[index].id),
                          icon: Icon(Icons.delete_sweep, color: Theme.of(context).errorColor,),
                          label: Text('delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete_sweep),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTxn(_transactions[index].id),
                        ),
                ),
              );
            },
          );
  }
}
