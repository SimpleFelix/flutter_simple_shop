import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String? title;
  NoDataWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/no_data.png',width: 250),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(title??'商品已下架或者删除'),
                )
              ],
            )),
      ),
    );
  }
}
