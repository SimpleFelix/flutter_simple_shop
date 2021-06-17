import 'package:dd_taoke_sdk/model/product.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import '../fluro/navigator_util.dart';

// 小部件
import '../widgets/coupon_price.dart';
import 'extended_image.dart'; // 原价和券后价小部件

// 瀑布流商品卡片
class WaterfallGoodsCard extends StatelessWidget {
  final Product product;

  WaterfallGoodsCard(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          NavigatorUtil.gotoGoodsDetailPage(context, product.id.toString());
        },
        child: Container(
            //width: Sc.ScreenUtil().setWidth(640), // (1440-150) / 2
            padding: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: <Widget>[
                _image(),

                SizedBox(height:12),

                // 标题
                _title(product.dtitle!),

                SizedBox(height:12),
                // 购买理由
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12),
                  child: Text(
                    product.desc!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12),
                  ),
                ),

                SizedBox(height: 12),

                /// 领券标签
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: FSuper(
                    lightOrientation: FLightOrientation.LeftBottom,
                    text:
                        '领 ${NumUtil.getNumByValueDouble(product.couponPrice, 0)} 元券',
                    padding: EdgeInsets.symmetric(
                        horizontal: 12),
                    strokeColor: Colors.pink,
                    corner: FCorner.all(10),
                    style: TextStyle(color: Colors.pink),
                  ),
                ),

                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      CouponPriceWidget(
                          actualPrice: product.actualPrice.toString(),
                          originalPrice: product.originalPrice),
                    ],
                  ),
                ),
//                _hot(product.twoHoursSales),
                // 图标或者标签显示
//                Container(
//                  margin: EdgeInsets.only(top: 5.0),
//                  child: Row(
//                    children: <Widget>[
//                      _tag('可领${product.couponPrice}元优惠券', Colors.pinkAccent),
//                      _iconByActivityType(product.activityType),
//                    ],
//                  ),
//                )
              ],
            )));
  }

  // 两小时销量
  Widget _hot(int twoHoursSales) {
    return Container(
      margin: EdgeInsets.only(top: 2.0, left: 5.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/icons/hot.png',
            height: 22,
            width: 22,
          ),
          Container(
            child: Text(
              '两小时销量$twoHoursSales,月销${product.monthSales}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.pinkAccent),
            ),
          )
        ],
      ),
    );
  }

  // 标题
  Widget _title(String dtitle) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                dtitle,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ));
  }

  // 商品卡片主图
  Widget _image() {
    var img = product.mainPic!;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: SimpleImage(url: img));
      },
    );
  }

  // 标签通用
  Widget _tag(String text, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(2.0))),
      child: Text(
        text,
        style:
            TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }

  // 活动类型，1-无活动，2-淘抢购，3-聚划算
  Widget _iconByActivityType(int activityType) {
    Widget icon = Text(''); // 默认无活动

    if (activityType == 3) {
      icon = Image.asset('assets/icons/jhs.png',
          height: 16,
          width: 16);
    }
    if (activityType == 2) {
      icon = Image.asset('assets/icons/qg.png',
          height: 16,
          width: 16);
    }
    return Container(margin: EdgeInsets.only(left: 5.0), child: icon);
  }

  // 是否12小时内上架 (1 - 是 ,0 不是)
  Widget _isNewGoods(int newRankingGoods) {
    return newRankingGoods == 1
        ? Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Image.asset('assets/icons/new.png',
                height: 16,
                width: 16),
          )
        : Text('');
  }
}
