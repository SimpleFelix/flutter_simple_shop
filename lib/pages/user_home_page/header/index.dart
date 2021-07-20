import 'package:demo1/modals/user.dart';
import 'package:demo1/provider/riverpod/user_riverpod.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils.dart';
import '../../../constant/style.dart';
import '../../../fluro/navigator_util.dart';

// 头部容器
class HeaderIndex extends StatelessWidget {
  HeaderIndex();

  final TextStyle subTitleStyle =
      TextStyle(color: Colors.black26, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          utils.widgetUtils.marginTop(),
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
              final user = watch(userModel).user;
              if (user == null) {
                return _loginWidgetLayout(context);
              }
              return _loginSuccessLayout(user);
            },
          )
        ],
      ),
    );
  }

  /// 已登录显示
  Widget _loginSuccessLayout(User user) {
    return Container(
      child: Row(
        children: [
          utils.widgetUtils.marginRight(),
          // 用户头像
          PhysicalModel(
            color: Colors.grey.shade200,
            elevation: 10,
            borderRadius: BorderRadius.circular(50),
            child: ExtendedImage.network(
              user.picture,
              width: 50,
              height: 50,
              borderRadius: BorderRadius.circular(50),
              shape: BoxShape.rectangle,
            ),
          ),
          utils.widgetUtils.marginRight(),
          // 昵称
          Text(
            '${user.nickName}',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
    );
  }

  /// 登录跳转
  Widget _loginWidgetLayout(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtil.gotoUserLoginPage(context),
      child: Text(
        '登录/注册',
        style: TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
