import 'package:demo1/common/utils.dart';
import 'package:demo1/constant/style.dart';
import 'package:demo1/fluro/NavigatorUtil.dart';
import 'package:demo1/modals/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 头部容器
class HeaderIndex extends StatelessWidget {
  final User? user;

  HeaderIndex(this.user);

  final TextStyle subTitleStyle =
      TextStyle(color: Colors.black26, fontSize: ScreenUtil().setSp(50));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          utils.widgetUtils.marginTop(),
          GestureDetector(
            onTap: () => NavigatorUtil.gotoUserLoginPage(context),
            child: Text(
              '登录/注册',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
