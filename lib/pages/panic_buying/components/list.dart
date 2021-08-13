// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';

// Project imports:
import '../../../common/utils.dart';

class ProductsList extends ConsumerWidget {
  final List<Product> products;

  ProductsList(this.products);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(child: Container(),);
    }
    return SliverPadding(
        padding: EdgeInsets.all(8),
        sliver: SliverWaterfallFlow.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: products.map(itemBuilder).toList()));
  }

  Widget itemBuilder(Product item) {
    return utils.widgetUtils.renderProductCard(item);
  }
}
