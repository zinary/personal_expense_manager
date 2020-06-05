import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTxn;

  ExpenseList(this._transactions,this.deleteTxn);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: _transactions.isEmpty
            ? Center(
                child: Text(
                  'No Expenses currently',
                  style: Theme.of(context).textTheme.headline6,
                ),
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
                              '₹' +
                                  _transactions[index]
                                      .amount
                                      .toStringAsFixed(0),
                              // style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        radius: 30,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_sweep),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTxn(_transactions[index].id),
                      ),
                    ),
                  );
                },
              ));
  }
}
