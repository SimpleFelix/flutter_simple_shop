// Flutter imports:
// Package imports:
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';

// Project imports:
import '../common/widgets/hot.dart';
import '../util/navigator_util.dart';
import '../widgets/coupon_price.dart';
import 'extended_image.dart';

// 瀑布流商品卡片
class WaterfallGoodsCard extends StatelessWidget {
  final Product product;

  WaterfallGoodsCard(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          NavigatorUtil.gotoGoodsDetailPage(context, product.id.toString(),
              newViewPage: true);
        },
        child: Container(
            //width: Sc.ScreenUtil().setWidth(640), // (1440-150) / 2
            padding: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: <Widget>[
                _image(),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [renderShopType(),renderCals()],
                  ),
                ),
                SizedBox(height: 5),

                // 标题
                _title(product.dtitle!),

                SizedBox(height: 5),
                // // 购买理由
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 12),
                //   child: Text(
                //     product.desc!,
                //     maxLines: 2,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 12),
                //   ),
                // ),

                // SizedBox(height: 12),

                /// 领券标签
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: FSuper(
                    lightOrientation: FLightOrientation.LeftBottom,
                    text:
                        '领 ${NumUtil.getNumByValueDouble(product.couponPrice, 0)} 元券',
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    strokeColor: Colors.pink,
                    corner: FCorner.all(50),
                    style: TextStyle(color: Colors.pink),
                  ),
                ),

                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: CouponPriceWidget(
                      actualPrice: product.actualPrice.toString(),
                      originalPrice: product.originalPrice),
                ),
                Hot(
                    text:
                        '两小时销量${product.twoHoursSales ?? 0},月销${product.monthSales}')
              ],
            )));
  }

  /// 销量
  Widget renderCals(){
    return Container(
      child: Text('月销${product.monthSales}',
      style: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(0, 0, 0, .32)
      ),
      ),
    );
  }


  /// 店铺类型
  Widget renderShopType() {
    final text = product.shopType == 0 ? '淘宝' : '天猫';
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(3)),
      child: Text(
        '$text',
        style: TextStyle(color: Colors.white,fontSize: 12),
      ),
    );
  }

  // 标题
  Widget _title(String dtitle) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                dtitle,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
            child: SimpleImage(
              url: img,
              radius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ));
      },
    );
  }
}
