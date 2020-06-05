import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String label;
  final Function handler;
  AdaptiveFlatButton({this.label, this.handler});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            
            child: Text(label),
            onPressed: handler,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColorDark,
            child: Text(
             label,
              
            ),
            onPressed: handler,
          );
  }
}
