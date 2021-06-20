import 'package:badges/badges.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/pages/jiujiu_page/goods_item_widget.dart';
import 'package:demo1/pages/panic_buying/repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListWithPanic extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final products = watch(panicBuyingRiverpod).products;
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, index) => itemBuilder(products[index],index),childCount: products.length));
  }

  Widget itemBuilder(Product item,int index) {
    return GoodsItemWidget(
      goodsItem: item,
      shopWidget:  Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Badge(
          padding: EdgeInsets.symmetric(horizontal: 6),
          toAnimate: true,
          shape: BadgeShape.square,
          elevation: 0,
          badgeColor: Colors.pink,
          borderRadius: BorderRadius.circular(5),
          badgeContent: Text('券${item.couponPrice.toString().split('.')[0]}元', style: TextStyle(color: Colors.white,fontSize: 12)),
        ),
      ),
      imageWidget:  Positioned(
        left: 2,
        child: Badge(
          shape: BadgeShape.circle,
          badgeColor: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
          badgeContent: Text('${index+4}', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
