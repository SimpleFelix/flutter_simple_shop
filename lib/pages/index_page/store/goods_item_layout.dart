// Flutter imports:
// Package imports:
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/material.dart';

import '../../../util/image_util.dart';
import '../../../util/navigator_util.dart';
// Project imports:
import 'price_layout.dart';

/// 商品卡片布局
class StoreGoodsItemLayout extends StatelessWidget {
  final Product storeGoods;

  const StoreGoodsItemLayout({Key? key, required this.storeGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigatorUtil.gotoGoodsDetailPage(context, storeGoods.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100]!.withOpacity(.8),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Image.network(MImageUtils.magesProcessor(storeGoods.mainPic!)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildDiscountLayout(),
                  )
                ],
              ),
              PriceLayout(original: '${storeGoods.actualPrice}'.replaceAll('.0', ''), discounts: '${storeGoods.originalPrice}'.replaceAll('.0', ''))
            ],
          ),
        ),
      ),
    );
  }

  /// 折扣小部件
  Widget _buildDiscountLayout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withOpacity(.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        '${storeGoods.discounts}折',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
