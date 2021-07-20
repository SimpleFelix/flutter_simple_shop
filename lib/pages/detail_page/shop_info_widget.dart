import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/util/image_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopInfoWidget extends StatelessWidget {
  final Product goodsInfo;

  ShopInfoWidget({required this.goodsInfo});

  @override
  Widget build(BuildContext context) {
    print('${goodsInfo.goodsId}店铺logo:${goodsInfo.shopLogo}');
    return Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // 商铺logo
                Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                  child:goodsInfo.shopLogo!.isNotEmpty? Image.network(
                    MImageUtils.magesProcessor(goodsInfo.shopLogo!),
                    width: 91,
                    height: 90,
                  ) : Image.asset('assets/images/ava.jpg',width:91,height:90,),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        goodsInfo.shopName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      Container(
                          child: Row(
                        children: <Widget>[
                          // 店铺类型
                          goodsInfo.shopType == 1
                              ? Image.asset(
                                  "assets/icons/tianmao.png",
                                  width: 12,
                                  height: 12,
                                )
                              : Image.asset(
                                  "assets/icons/taobao.png",
                                  width: 12,
                                  height: 12,
                                ),

                          //是否金牌卖家
                          goodsInfo.goldSellers == 1
                              ? Container(
                                  margin: EdgeInsets.only(left: 5.0),
                                  child: Image.asset(
                                    "assets/icons/jinpai.png",
                                    width: 12,
                                    height: 12,
                                  ),
                                )
                              : Container()
                        ],
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Container(
                    child: ElevatedButton(
                      child: Text("全部商品"),
                      onPressed: (){},
                    ),
                  ),
                )
              ],
            ),

            // 描述
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color.fromRGBO(245, 245, 249, 1.0)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text("宝贝描述:${goodsInfo.descScore}"),
                  ),
                  Container(
                    child: Text("卖家服务:${goodsInfo.serviceScore}"),
                  ),
                  Container(
                    child: Text("物流服务:${goodsInfo.shipScore}"),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
