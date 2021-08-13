// Flutter imports:
// Package imports:
import 'package:common_utils/common_utils.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:fbutton_nullsafety/fbutton_nullsafety.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

// Project imports:
import '../../../common/toast.dart';
import '../../../common/utils.dart';
import '../../../util/navigator_util.dart';
import '../../../widgets/extended_image.dart';
import '../../../widgets/simple_price.dart';
import '../pyq_riverpod.dart';

class PyqList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final product = watch(pyqRiverpod).products;
    if (product.isEmpty) return SliverToBoxAdapter();
    return SliverWaterfallFlow.count(
      crossAxisCount: 1,
      children: product.map(renderItem).toList(),
    );
  }

  Widget renderItem(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/dd.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text('梁典典'),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text(
                        '创建了${NumUtil.getNumByValueDouble(product.couponPrice,0)}元券',
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            indent: 12,
          ),
          Html(
            data: '${product.circleText}',
            style: {'body': Style(color: Colors.grey)},
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onTap: (){
                      NavigatorUtil.gotoGoodsDetailPage(Get.context!, '${product.id}',newViewPage: true);
                    },
                    child: SimpleImage(
                      url: product.mainPic!,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(minHeight: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          NavigatorUtil.gotoGoodsDetailPage(Get.context!, '${product.id}',newViewPage: true);
                        },
                        child: Text(
                          '${product.dtitle}',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimplePrice(
                            price: '${product.actualPrice}',
                            hideText: '',
                            orignPrice: '${product.originalPrice}',
                            fontSize: 22,
                            color: Colors.pink,
                          ),


                          FButton(
                            text: '复制口令',
                            color: Colors.white,
                            onPressed: () async {

                              showLoading(Get.context!);
                             final result = await DdTaokeSdk.instance.getCouponsDetail(taobaoGoodsId: '${product.goodsId}');
                              if(result!=null){
                                utils.copy(result.longTpwd,message: '复制成功,打开淘宝即可领取优惠券');
                              }
                              closeLoading();
                            },
                            strokeWidth: 1,
                            strokeColor: Colors.grey.shade200,
                            clickEffect: true,
                            corner: FCorner.all(28),
                            shadowColor: Colors.grey.shade100,
                            shadowBlur: 10, highlightColor: Colors.green.shade50,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            style: TextStyle(
                              color: Colors.pinkAccent,fontSize: 12
                            ),
                          ),


                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
