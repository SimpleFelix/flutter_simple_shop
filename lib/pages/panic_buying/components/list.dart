import 'package:dd_taoke_sdk/model/product.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../../common/utils.dart';
import '../repository.dart';

class ProductListWithPanic extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final products = watch(panicBuyingRiverpod).products;
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
    return SliverPadding(padding: EdgeInsets.all(8), sliver: SliverWaterfallFlow.count(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, children: products.map(itemBuilder).toList()));
  }

  Widget itemBuilder(Product item) {
    return utils.widgetUtils.renderProductCard(item);
  }
}
