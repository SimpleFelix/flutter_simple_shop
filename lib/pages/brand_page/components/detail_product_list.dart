import 'package:flutter/material.dart';

import '../../../util/image_util.dart';
import '../../index_page/store/price_layout.dart';
import '../models/brand_detail_model.dart';

/// 品牌的商品列表
class DetailProductList extends StatelessWidget {
  final List<BrandDetailGoodsList>? list;

  const DetailProductList({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate:
            SliverChildBuilderDelegate(_builderList, childCount: list!.length));
  }

  Widget _builderList(BuildContext context, int index) {
    var brandDetailGoodsList = list![index];
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            _buildImage(brandDetailGoodsList),
            SizedBox(width: 12,),
            Expanded(child: _buildData(brandDetailGoodsList))
          ],
        ),
      ),
    );
  }

  Widget _buildData(BrandDetailGoodsList item) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.dTitle!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Column(
            children: [PriceLayout(original: item.actualPrice.toString(), discounts: item.originPrice.toString(),)],
          )
        ],
      ),
    );
  }

  // 商品主图
  Widget _buildImage(BrandDetailGoodsList item) {
    var imageSize = Size(200, 200);
    return Container(
        color: Colors.grey[200],
        child: Image.network(
          MImageUtils.magesProcessor(item.mainPic!),
          width: imageSize.width,
          height: imageSize.height,
        ));
  }
}
