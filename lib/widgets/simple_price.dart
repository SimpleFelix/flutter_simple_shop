import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

class SimplePrice extends StatelessWidget {
  final String price;
  final String? orignPrice; // 原价
  final String? zhe; // 折扣
  final double? fontSize; // 大小
  final String? hideText; // 隐藏文字
  final Color? color;
  const SimplePrice({Key? key,required this.price, this.orignPrice, this.zhe, this.hideText, this.fontSize, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FSuper(
      lightOrientation: FLightOrientation.LeftBottom,
      text: hideText ?? '券后价 ',
      style: TextStyle(
        fontSize:fontSize!=null ? fontSize! * .7 : 12,
        color: color ?? Colors.red
      ),
      spans: [
        TextSpan(text: ' ¥', style: TextStyle(color:color?? Colors.red, fontSize: ScreenUtil().setSp(60), fontWeight: FontWeight.w800)),
        TextSpan(
          text: '$price ',
          style: TextStyle(color:color ?? Colors.red, fontSize:fontSize ?? ScreenUtil().setSp(100), fontWeight: FontWeight.w800),
        ),
        if(zhe!=null)
        TextSpan(
          text: '$zhe折',
          style: TextStyle(fontSize: ScreenUtil().setSp(50)),
        ),
        if(orignPrice!=null)
          TextSpan(text:'原价$orignPrice',style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey
          ))
      ],
    );
  }
}
