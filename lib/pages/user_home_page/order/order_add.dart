// Dart imports:
import 'dart:math';

// Package imports:
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart' as controller;
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

// Project imports:
import '../../../util/system_toast.dart';
import '../../../util/user_utils.dart';

class OrderAddIndexPage extends StatefulWidget {
  @override
  _OrderAddState createState() => _OrderAddState();
}

class _OrderAddState extends State<OrderAddIndexPage> {
  double svgSize = 220.0;
  double placeholderHeight =12;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('订单绑定'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            buildPlaceHolderSizedBox(),
            Container(
              child: Center(
                  child: SvgPicture.asset(
                      'assets/svg/undraw_shopping_app_flsj.svg',
                      height: svgSize,
                      width: svgSize)),
            ),
            buildPlaceHolderSizedBox(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: textEditingController,
                autofocus: false,
                decoration: InputDecoration(hintText: '输入订单编号'),
              ),
            ),
            buildPlaceHolderSizedBox(),
            Container(
              child: FButton(
                width: 200,
                height: 55,
                text: '绑定',
                color: Colors.pinkAccent,
                onPressed: () async {

                  // 获取文本框订单编号
                  var orderNumber = textEditingController.value.text;
                  if(orderNumber.length!=19){
                    SystemToast.show('订单编号格式不正确');
                    return null;
                  }
                  await UserUtil.loadUserInfo().then((user) async {
                    if (user != null) {
                    }
                  });
                },
                clickEffect: true,
                padding: EdgeInsets.zero,
                highlightColor: Color(0xffE65100).withOpacity(0.20),
                hoverColor: Colors.redAccent.withOpacity(0.16),
              ),
            ),
            buildPlaceHolderSizedBox(),
            Container(
              child: FSuper(
                lightOrientation: controller.FLightOrientation.LeftBottom,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                    (16.0 + 25.0 + 12), 8, (0.0 + 8.0), 8),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                backgroundColor: Color(0xfffff0e7),
                strokeColor: Color(0xfffee0cd),
                strokeWidth: 1,
                text: '注意事项',
                textAlignment: Alignment.centerLeft,
                textAlign: TextAlign.left,
                spans: [
                  TextSpan(
                    text: '\n只有通过本站链接购买的订单才能审核通过并获得奖励,否则绑定失败.(多次绑定失败将封号处理)',
                    style: TextStyle(color: Colors.black26)
                  )
                ],
                child1: Transform.rotate(
                  angle: pi,
                  child: Icon(
                    Icons.info,
                    size: 25,
                    color: Color(0xfffd6721),
                  ),
                ),
                child1Alignment: Alignment.centerLeft,
                child1Margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
              ),
            ),
            buildPlaceHolderSizedBox(),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Image.asset('assets/images/order_help.jpg'),
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildPlaceHolderSizedBox() => SizedBox(height: placeholderHeight);


  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }
}
