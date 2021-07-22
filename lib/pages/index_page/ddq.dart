import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './index_layout.dart';
import '../../util/navigator_util.dart';
import '../../provider/ddq_provider.dart';
import '../../widgets/extended_image.dart';
import 'component/component_title.dart';

// 钉钉抢
class DDQWidget extends StatefulWidget {
  @override
  _DDQWidgetState createState() => _DDQWidgetState();
}

class _DDQWidgetState extends State<DDQWidget> {
  final GlobalKey globalKey = GlobalKey();
  DdqProvider? ddqProvider;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<DdqProvider>(
      builder: (context, ddqProvider, _) => IndexPublicLayout(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: <Widget>[
              ComponentTitle(
                title: '限时抢购',
                height: 100,
                onTap: NavigatorUtil.goTODdqPage,
              ),
              SizedBox(
                height: 12,
              ),
              _buildWidgetGoosList(),
            ],
          ),
        ),
      ),
    );
  }

  /// 商品列表version2
  Widget _buildWidgetGoosList() {
    var list = ddqProvider!.goodsList;
    if (list.length >= 3) {
      return Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            _mimiGoodsCard(
                list[0].mainPic,
                list[0].actualPrice.toString(),
                list[0].originalPrice.toString(),
                list[0].monthSales.toString(),
                list[0].dtitle!),
            SizedBox(width: 12),
            _mimiGoodsCard(
                list[1].mainPic,
                list[1].actualPrice.toString(),
                list[1].originalPrice.toString(),
                list[1].monthSales.toString(),
                list[1].dtitle!),
            SizedBox(width: 12),
            _mimiGoodsCard(
                list[2].mainPic,
                list[2].actualPrice.toString(),
                list[2].originalPrice.toString(),
                list[2].monthSales.toString(),
                list[2].dtitle!),
          ],
        ),
      );
    }
    return Row(
      children: <Widget>[],
    );
  }

  // 商品卡片布局
  Widget _mimiGoodsCard(
      String? src, String price, String orginPrice, String xl, String title) {
    return Flexible(
      flex: 1,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth,
                    child: SimpleImage(url: src!)),
                SizedBox(height: 12),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 6),
                Container(
                  child: Row(
                    verticalDirection: VerticalDirection.up,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '￥$price',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize:12),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '￥$orginPrice',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize:12,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    var ddqProvider = Provider.of<DdqProvider>(context);
    if (this.ddqProvider != ddqProvider) {
      this.ddqProvider = ddqProvider;
      await Future.delayed(Duration(seconds: 1), () {
        ddqProvider.loadData();
      });

      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }
}
