// Flutter imports:
import 'package:flutter/material.dart';

class DetailSimpleBorderButton extends StatelessWidget {
 final  String text; // 文字
 final bool isCurrent; // 是否选中样式

  DetailSimpleBorderButton({required this.text, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border:isCurrent? Border(bottom: BorderSide(color: Colors.pinkAccent,width: 2.0)):null
      ),
      child: Text(text,
      style: TextStyle(
        color: isCurrent?Colors.pinkAccent:Colors.black,
            fontWeight:isCurrent?FontWeight.w600:null
      )),
    );
  }
}
