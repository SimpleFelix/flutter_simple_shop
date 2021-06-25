import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo1/pages/index_page/store/price_layout.dart';
import 'package:flutter/material.dart';

/// 商品卡片布局
class StoreGoodsItemLayout extends StatelessWidget {
  final Product storeGoods;

  const StoreGoodsItemLayout({Key? key, required this.storeGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            PriceLayout(original: '${storeGoods.actualPrice}', discounts: '${storeGoods.originalPrice}')
          ],
        ),
      ),
    );
  }

  /// 折扣小部件
  Widget _buildDiscountLayout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withOpacity(.5),
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      ),
      child: Text(
        "${storeGoods.discounts}折",
        style: TextStyle(fontSize: 50.sp, color: Colors.white),
      ),
    );
  }
}
