import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addListFunc;
  NewTransaction(this.addListFunc);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextController = TextEditingController();

  final amountTextController = TextEditingController();
  DateTime selectedDate;

  void submitValue() {
    final enteredtitle = titleTextController.text;
    final enteredAmount = amountTextController.text;
    if (enteredAmount.isEmpty) {
      return;
    }
    if (enteredtitle.isEmpty ||
        double.parse(enteredAmount) <= 0 ||
        selectedDate == null) {
      return;
    }

    widget.addListFunc(
        enteredtitle,
        double.parse(
          enteredAmount,
        ),
        selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
          child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15,
            // bottom: 500
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleTextController,
                onSubmitted: (_) => submitValue(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountTextController,
                onSubmitted: (_) => submitValue(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(selectedDate == null
                          ? 'No date selected!'
                          : 'Picked Date: ' +
                              DateFormat.yMMMEd().format(selectedDate))),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () => presentDatePicker(context),
                    child: Text('Choose Date'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => submitValue(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
