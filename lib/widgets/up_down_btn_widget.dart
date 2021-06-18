import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpDownBtnWidget extends StatelessWidget {
  final bool? isCur;
  final String? upText;
  final String? downText;

  UpDownBtnWidget({this.isCur, this.downText, this.upText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isCur!
            ? Color.fromRGBO(254, 62, 59, 1.0)
            : Color.fromRGBO(248, 248, 248, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(right: 10.0, top: 8, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(upText!,
              style: TextStyle(
                  color: isCur! ? Colors.white : Colors.black38, fontSize: 12)),
          Text(downText!,
              style: TextStyle(
                  color: isCur! ? Colors.white : Colors.black38, fontSize: 12))
        ],
      ),
    );
  }
}
