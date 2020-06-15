import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './widgets/expense_list.dart';
import './widgets/new_transaction.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.deepOrange,
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
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 25,fontWeight: FontWeight.bold),
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

  bool _showChart = false;

  void _addTransactions(String title, double amount, DateTime selecdedDate) {
    final newTxn = Transaction(
        title: title,
        amount: amount,
        date: selecdedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTxn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((txn) => txn.id == id);
    });
  }

  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
      elevation: 10,
      // useRootNavigator:true,
      // isDismissible: true,
      // enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)
      ),),
      
     isScrollControlled: true, 
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransactions);
        });
  }

    List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,AppBar appBar, Widget _transactionListWidget)
    {
      return  [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart'),
              Switch.adaptive(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  }),

            ],

          ), _showChart
              ? Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: Chart(_recentTransactions),
                )
              : _transactionListWidget];
    }
    List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,AppBar appBar,_transactionListWidget){
      return [ Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.25,
            child: Chart(_recentTransactions),
          )
          , _transactionListWidget];
    }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.only(top: 5,bottom: 5),
            middle: Text('Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add,color: Colors.blue,),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ))
        : AppBar(
            title: Text('Expenses'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final _transactionListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: ExpenseList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(child: Column(
      children: <Widget>[
        
        //show switch if landscape
        if (_isLandscape) ..._buildLandscapeContent(mediaQuery, appBar, _transactionListWidget),
         
        //if portrait show both chart and txn list
        if (!_isLandscape) ..._buildPortraitContent(mediaQuery, appBar, _transactionListWidget),
          

      
         
      ],
    )
    ,) ;
    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    // backgroundColor: Colors.purple,
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
