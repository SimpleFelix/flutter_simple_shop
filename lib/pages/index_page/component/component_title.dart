import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComponentTitle extends StatelessWidget {
  final String title;
  final double height;
  final VoidCallback? onTap;
  const ComponentTitle({Key? key,required this.title, required this.height, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(70)),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
