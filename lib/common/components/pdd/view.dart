import 'package:common_utils/common_utils.dart';
import 'package:demo1/widgets/component/coupon_discount.dart';
import 'package:demo1/widgets/extended_image.dart';
import 'package:demo1/widgets/simple_price.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../modals/pdd_product.dart';
import 'resp.dart';

class PddRecommendListView extends StatefulWidget {
  const PddRecommendListView({Key? key}) : super(key: key);

  @override
  _PddRecommendListViewState createState() => _PddRecommendListViewState();
}

class _PddRecommendListViewState extends State<PddRecommendListView> {
  PddRecommendListResp pddRecommendListResp = PddRecommendListResp();

  @override
  Widget build(BuildContext context) {
    return LoadingMoreList(
      ListConfig<PddGoods>(
        extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: renderIten,
        sourceList: pddRecommendListResp,
        padding: EdgeInsets.all(12),
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics()
      ),
    );
  }

  // 渲染item
  Widget renderIten(_, PddGoods item, int index) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                renderImage(constraints, item),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.goodsName}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SimplePrice(price: '${MoneyUtil.changeF2Y(item.minGroupPrice)}'),
                      CouponDiscountShow(value: '${MoneyUtil.changeF2Y(item.couponDiscount)}'.replaceAll('.00', ''))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  SizedBox renderImage(BoxConstraints constraints, PddGoods item) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxWidth,
      child: SimpleImage(
        url: item.goodsImageUrl,
        radius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5)),
      ),
    );
  }
}
