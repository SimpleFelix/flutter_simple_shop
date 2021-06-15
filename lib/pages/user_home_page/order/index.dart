import 'package:demo1/fluro/navigator_util.dart';
import 'package:demo1/pages/user_home_page/widgets/svg_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _actions(context);
  }

  Widget _actions(BuildContext context) {
    return GridView.count(shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        InkWell(
          onTap: () {
            NavigatorUtil.gotoOrderAllIndexPage(context, "-1"); // -1表示全部显示
          },
          child: SvgTitle(title: "全部订单", svgPath: "assets/svg/order.svg"),
        ),
        SvgTitle(title: "已通过", svgPath: "assets/svg/order2.svg"),
        SvgTitle(title: "等待审核", svgPath: "assets/svg/order3.svg"),
        SvgTitle(title: "无效订单", svgPath: "assets/svg/order4.svg"),
      ],
    );
  }
}
