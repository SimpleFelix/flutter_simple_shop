import 'package:flutter/material.dart';

class Hot extends StatelessWidget {
  final String text;
  const Hot({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 2.0, left: 5.0),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icons/hot.png',
              height: 22,
              width: 22,
            ),
            Expanded(
              child: Container(
                child: Text(
                  '$text',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
