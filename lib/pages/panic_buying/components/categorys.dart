import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../repository.dart';

class CategorysWithPanicBuying extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLoading = watch(panicBuyingRiverpod).initLoading;
    final cates = watch(panicBuyingRiverpod).cates;
    if (isLoading) return Container();
    return DefaultTabController(
      length: cates.length,
      child: TabBar(
        tabs: cates.map(_renderItem).toList(),
        isScrollable: true,
        indicator: BubbleTabIndicator(
          indicatorHeight: 25.0,
          indicatorColor: Colors.white,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
          // indicatorRadius: 1,
          // insets: EdgeInsets.all(1),
          // padding: EdgeInsets.all(10)
        ),
        unselectedLabelColor: Colors.white.withOpacity(.67),
        labelColor: Colors.red,
      ),
    );
  }

  // 渲染分类
  Widget _renderItem(Category item) {
    return Tab(
      child: Text('${item.cname}'),
    );
  }
}
