// Flutter imports:
import 'package:flutter/material.dart';

class IndexHomeBanner extends StatelessWidget {
  final info =
      'A banner displays an important, succinct message, and provides actions for users to address. '
      'A user action is required for itto be dismissed.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[MaterialBanner(
        content: Text(
          info,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        leading: Icon(Icons.warning, color: Colors.yellow),
        padding: EdgeInsetsDirectional.only(start: 16.0, top: 2.0,end: 2),
        leadingPadding:EdgeInsetsDirectional.only(end: 16.0) ,
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: Text(
              'I KNOW',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),

          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: Text(
              'I IGNORE',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      )],
    );
  }

}
