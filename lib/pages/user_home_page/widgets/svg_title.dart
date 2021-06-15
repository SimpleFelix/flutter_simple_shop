import 'package:demo1/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SvgTitle extends StatelessWidget {
  final String? svgPath;
  final String? title;
  final VoidCallback? onTap;

  SvgTitle({this.title, this.svgPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              svgPath!,
              width: 25,
              height: 25,
              color: Colors.black,
            ),
            utils.widgetUtils.marginTop(height: 5),
            Text(
              title!,
              style: TextStyle(fontSize: ScreenUtil().setSp(50)),
            )
          ],
        ),
      ),
    );
  }
}
