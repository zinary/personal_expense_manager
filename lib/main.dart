import 'package:flutter/material.dart';

import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/expense_list.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'Nunito', fontSize: 25),
              ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
     return txn.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransactions(String title, double amount,DateTime selecdedDate) {
    final newTxn = Transaction(
        title: title,
        amount: amount,
        date: selecdedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTxn);
    });
  }
void _deleteTransaction(String id){
  setState(() {
    _userTransactions.removeWhere((txn) =>txn.id == id);
    
  });
}
  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransactions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: <Widget>[
                  Chart(_recentTransactions),
          ExpenseList(_userTransactions,_deleteTransaction),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // backgroundColor: Colors.purple,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
