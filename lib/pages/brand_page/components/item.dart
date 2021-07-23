import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../../../util/image_util.dart';
import '../../../util/number_cover.dart';
import '../../index_page/store/goods_item_layout.dart';
import '../brand_detail.dart';

/// 品牌布局
class BrandItemCard extends StatelessWidget {
  final ListElement storeInfo;

  const BrandItemCard({Key? key, required this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.navigator.push(SwipeablePageRoute(
            builder: (_) => BrandDetailPage(brandId: storeInfo.brandId.toString())));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [_buildHeader(), _buildGoodsGrid()],
        ),
      ),
    );
  }

  /// 品牌信息栏目
  Widget _buildHeader() {
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          _buildHeaderFlexCore(
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.network(
                  MImageUtils.magesProcessor(storeInfo.brandLogo!),
                  width: 50,
                  height: 50,
                ),
              ),
              1),
          _buildHeaderFlexCore(
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${storeInfo.brandName}',
                          style: TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '已售${Numeral(storeInfo.sales!)}件 >',
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        )
                      ],
                    ),
                    Text(
                      '单品低至${storeInfo.maxDiscount}折  |  领券最高减${storeInfo.maxDiscountAmount}',
                      style: TextStyle(fontSize: 12, color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              5),
        ],
      ),
    );
  }

  /// 产品列表
  Widget _buildGoodsGrid() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: .8,
      shrinkWrap: true,
      crossAxisSpacing: 12,
      physics: NeverScrollableScrollPhysics(),
      children: [
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList![0]),
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList![1]),
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList![2]),
      ],
    );
  }

  Widget _buildHeaderFlexCore(Widget widget, int flex) {
    return Flexible(
      flex: flex,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(5),
        child: widget,
      ),
    );
  }
}
