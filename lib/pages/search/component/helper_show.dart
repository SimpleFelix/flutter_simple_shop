import 'package:flutter/material.dart';

/// 帮助组件
class HelperComp extends StatelessWidget {
  const HelperComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '三步轻松获得优惠券',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _renderItem('1.进入淘宝', 'step1.png'),
              _renderItem('2.复制商品标题', 'step2.png'),
              _renderItem('3.点击搜索查询', 'step3.png'),
            ],
          )
        ],
      ),
    );
  }

  /// 渲染项
  Widget _renderItem(String text, String img) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icons/$img',
          width: 15,
          height: 15,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12,color: Color(0xff555555)),
        )
      ],
    );
  }
}
