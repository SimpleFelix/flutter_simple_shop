import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/utils.dart';
import '../../fluro/navigator_util.dart';
import '../../widgets/extended_image.dart';
import '../../widgets/tag_widget.dart';

// 9.9商品卡片布局
class GoodsItemWidget extends StatelessWidget {
  final Product goodsItem;
  final Widget? shopWidget;
  final Widget? imageWidget;
  final EdgeInsets? margin;

  GoodsItemWidget({required this.goodsItem, this.shopWidget, this.imageWidget, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:margin ?? EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      width: Get.width,
      child: Row(
        children: <Widget>[
          utils.widgetUtils.marginRight(),
          // 商品图片
          SizedBox(
            width: 110,
            height: 110,
            child: Stack(
              children: [
                SimpleImage(
                  url: goodsItem.mainPic!,
                ),
                imageWidget??Container()
              ],
            ),
          ),
          utils.widgetUtils.marginRight(),
          Expanded(
              child: InkWell(
            onTap: () {
              NavigatorUtil.gotoGoodsDetailPage(
                  context, goodsItem.id.toString(),newViewPage: true);
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //上面部分
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //标题
                          Text(goodsItem.dtitle!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          //店铺
                          shopWidget ?? TagWidget(
                              title: goodsItem.shopName??'', noBorder: true),

                          //券后价
                          Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: 12)),
                                TextSpan(
                                    text: '${goodsItem.actualPrice}',
                                    style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: '  券后价    ',
                                    style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: 12)),
                                TextSpan(
                                    text: '原价${goodsItem.originalPrice}',
                                    style: TextStyle(
                                        color: Colors.black38,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12)),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    //下面部分
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 238, 230, 1.0),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100.0),
                                    bottomRight: Radius.circular(100.0))),
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: '已售',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(137, 60, 17, 1.0)),
                                ),
                                TextSpan(
                                  text: ' ${goodsItem.monthSales} ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(255, 91, 0, 1.0)),
                                ),
                                TextSpan(
                                  text: '件',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(137, 60, 17, 1.0)),
                                )
                              ]),
                            ),
                          ),
                          Positioned(
                            right: -3.3,
                            top: 0,
                            child: Image.asset(
                              'assets/images/lijigoumai.png',
                              width: 120,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 60,
                                child: Text(
                                  '立即购买',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    )
                  ]),
            ),
          ))
        ],
      ),
    );
  }
}
