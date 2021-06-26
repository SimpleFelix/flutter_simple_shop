import 'package:dd_taoke_sdk/model/product.dart';
import 'package:demo1/pages/jiujiu_page/riverpod.dart';
import 'package:demo1/widgets/waterfall_goods_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

class JiuJiuProductList extends ConsumerWidget{
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final products = watch(jiujiuRiverpod).products;
    return SliverPadding(
      padding: EdgeInsets.all(8),
        sliver: SliverWaterfallFlow.count(crossAxisCount: 2,children: products.map(renderItem).toList(),mainAxisSpacing: 8,crossAxisSpacing: 8,));
  }

  Widget renderItem(Product item){
    return PhysicalModel(
      color: Colors.grey.shade100,
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: WaterfallGoodsCard(item),
    );
  }
}