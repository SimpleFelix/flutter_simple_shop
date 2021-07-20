import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';

// 底部浮动操作按钮
class ActionButtons extends StatelessWidget {
  final String? goodsId;
  final Function? getCallBack;

  ActionButtons(
      {this.goodsId,
      this.getCallBack});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom:12,
      left:12,
      child: FSuper(
        lightOrientation: FLightOrientation.LeftBottom,
        width:Get.width,
        height: 120,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
        shadowColor: Colors.black26,
        shadowBlur: 10,
        child2: Row(
          children: <Widget>[
            Container(
              width: Get.width/2,
              height: 100,
              padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FSuper(
                    lightOrientation: FLightOrientation.LeftBottom,
                    height:120,
//                    width: ScreenUtil().setWidth(180),
                    text: '首页',
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.home,
                      size: 12,
                    ),
                  ),
                  FSuper(
                    lightOrientation: FLightOrientation.LeftBottom,
                    height: 120,
//                    width: ScreenUtil().setWidth(180),
                    text: '分享',
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.share,
                      size: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                    },
                    child: FSuper(
                      lightOrientation: FLightOrientation.LeftBottom,
                      height: 120,
//                    width: ScreenUtil().setWidth(180),
                      text: '收藏',
                      textAlignment: Alignment.bottomCenter,
                      child1Alignment: Alignment.topCenter,
                      child1: Icon(
                        Icons.favorite_border,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            FSuper(
              lightOrientation: FLightOrientation.LeftBottom,
              width: 200,
              height: 120,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              gradient: LinearGradient(colors: [
                Color(0xfff093fb),
                Color(0xfff5576c),
              ]),
              child2: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      '复制口令',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                      height: 120,
                      child: VerticalDivider(color: Colors.white)),
                  InkWell(
                    onTap: getCallBack as void Function()?,
                    child: Container(
                      child: Text(
                        '领券购买',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
