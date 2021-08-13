// Flutter imports:
// Package imports:
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../common/utils.dart';
import '../../../util/image_util.dart';
// Project imports:
import '../../../util/navigator_util.dart';
import '../../../widgets/component/coupon_discount.dart';
import '../../../widgets/simple_price.dart';

/// 品牌的商品列表
class DetailProductList extends StatelessWidget {
  final List<Product> list;

  const DetailProductList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate(_builderList, childCount: list.length));
  }

  Widget _builderList(BuildContext context, int index) {
    var brandDetailGoodsList = list[index];
    return GestureDetector(
      onTap: () {
        NavigatorUtil.gotoGoodsDetailPage(context, brandDetailGoodsList.id.toString());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            _buildImage(brandDetailGoodsList),
            utils.widgetUtils.marginRight(),
            Expanded(child: _buildData(brandDetailGoodsList))
          ],
        ),
      ),
    );
  }

  Widget _buildData(Product item) {
    return Container(
      constraints: BoxConstraints(minHeight: 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title!,
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          CouponDiscountShow(value: item.couponPrice.toString().replaceAll('.0', '')),
          SimplePrice(
            price: item.actualPrice.toString(),
            orignPrice: item.originalPrice.toString(),
          ),
        ],
      ),
    );
  }

  // 商品主图
  Widget _buildImage(Product item) {
    var imageSize = Size(120, 120);
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ExtendedImage.network(
          MImageUtils.magesProcessor(item.mainPic!),
          width: imageSize.width,
          height: imageSize.height,
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
        ));
  }
}
